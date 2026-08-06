Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011764248C4
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053246; cv=none; b=khk0ibCNl7VFO81WjiZ6fCedz7Z+nzmyKU+rwycangxnRQN6mqj24aH59KEkdLR5mWsICzhXPk1m1NtsZNn9QRPHT1DF4d83chHJhBdmkAdkRvTOwif8nZmXWTeNIh46wmOYn0Omh+t+oOgAC8d2QP0MJvxPEYXN/j6AtNusZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053246; c=relaxed/simple;
	bh=rvUckQkJEHeRtXVvkXAYofNiY08IttV9gJmTNXcj1m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XJTX332m9xnXr4dJ7EmA2lPH9MhCKu76DHuUtU2jcEonwxXzd54CLvxXU2aIB4I62qlDUzQUnfSpO4MdrD6TY4Bp6S3yihlPanhhL8BbWLnSN6cGDYvFJd7Lwe8Jz34BERdVNgDrM1fTCZMMiSgk+hRgdem87dDHaYeQuTARi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eGKouFk5; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eGKouFk5"
Message-ID: <078e91be-92d2-4ea7-94e1-a81562a35a3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786053239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNUnSUo9j2lylW9H7jRdn6EGuMQN4/G38HBbMuCrfKs=;
	b=eGKouFk5P+CY6lsFvC2o6ah3HsPPrviHFTTBPd+dK2Y5HwNykVtxtI8edUaknSaesiGauX
	epXUwPm0lFxL97NAnI2iyYFRpsZcX6NjpeZnfXAxJayvXsPWS9TpoIYe8ZVqimQGCdWfab
	NcaKK/FE5/KntOJ3fMOdPc1/SuwtMGc=
Date: Thu, 6 Aug 2026 14:53:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Sanitize traffic monitor log file
 names
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org
References: <20260806211105.3307932-1-vineet.gupta@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260806211105.3307932-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 2:11 PM, Vineet Gupta wrote:
> The traffic monitor names its capture logs after the test and subtest
> being run, replacing '/' and ' ' so the result is usable as a file name.
> Test names are free form though, and other characters make it through.
> A subtest called "INET4: bpf timestamping" produces
> 
>   /tmp/tmon_pcap/packets-125-15-net_timestamping__INET4:_bpf_timestamping-net_timestamping_ns.log
> 
> CI systems that collect these logs as artifacts reject such names.
> GitHub Actions' upload-artifact fails the upload with
> 
>   Error: The path for one of the files in artifact is not valid:
>   ... Contains the following character:  Colon :
> 
> Replace the whole set of awkward characters in one pass rather than
> adding another strchr() loop per character. Note the loop tests *p
> before calling strchr(), so the terminating NUL is never passed to it.
> 
> This came up as a side error/annoyance when trying to re-enable BPF-GCC
> CI runs [1]. The CI side already has path name normalization and needs
> some tweaking as well, however fixing it at the source also makes sense.
> 
> Fixes: f52403b6bfea ("selftests/bpf: Add traffic monitor functions.")
> Link: https://github.com/kernel-patches/vmtest/actions/runs/30710914503/job/91399011388 [1]
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---
>  tools/testing/selftests/bpf/network_helpers.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index db935a9d9fc1..3818cec354a0 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -1142,10 +1142,13 @@ static void encode_test_name(char *buf, size_t len, const char *test_name, const
>  		snprintf(buf, len, "%s__%s", test_name, subtest_name);
>  	else
>  		snprintf(buf, len, "%s", test_name);
> -	while ((p = strchr(buf, '/')))
> -		*p = '_';
> -	while ((p = strchr(buf, ' ')))
> -		*p = '_';
> +	/* Test names are free form, so replace anything that is awkward in a
> +	 * file name. Besides the path separator, this covers the characters
> +	 * rejected by CI systems collecting these logs as artifacts.
> +	 */
> +	for (p = buf; *p; p++)
> +		if (strchr("/ \":<>|*?\r\n", *p))

Hi Vineet,

We already do this on the CI side here:
https://github.com/libbpf/ci/blob/main/run-vmtest/normalize-paths-for-github.sh

The problem on the CI side is that the script is not executed
in some corner cases, like a VM timeout.

I don't think this change is necessary upstream: the paths are
technically valid, it's an issue for CI only due to github quirks.

> +			*p = '_';
>  }
>  
>  #define PCAP_DIR "/tmp/tmon_pcap"

