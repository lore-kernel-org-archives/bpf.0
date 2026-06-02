Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21521DF73C
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429433; cv=none; b=Kdd0qcrx/aBLQBf9z9TYooblei8le/vnvKxdx9P2yoUTlZneCk3nPmC5xx4a1IwmdxFjMnznZWeTyqGLB9pTYbDuLObsBfqXR9oxAmFZ7TdhOop3n4VTQiw+D0gQlOvBNBHHdbFFJlAEFehXZBQvZknC+NIjxeNXtecGWhwrF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429433; c=relaxed/simple;
	bh=ETvbJBR9KyPKJ9m5/h0+VoD4ySzXGaqEsXb/F2ACrlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ5QYNHvXru2HuiKi2W4RmDSswWa3d4TfybKz7T8bqtGAHVj8ztl2MIkyfTVRfDKCujUZ/aR44cBxRFoQhm8jhrdIfEvh120LNQUB6/PVfD4ynLGbtBRYAmjJjwvHKDv9oybCiMj1VTKTVsLXzOaex6vUq5E7HXU7kKdDmpBuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pNvv4ssP; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pNvv4ssP"
Message-ID: <18dda63b-79d0-47ad-b60b-82436ae0a017@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780429429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=md3IbFJBgbDRnWeSfl2Qly7DbFAyfCuW+zKnCWhDxMY=;
	b=pNvv4ssPO2t88n1MrbNpTN5iZBwo8jAHa3WZk3EdH1Pmqy0e6Ltq99Lk8g+EpaUSN9Fry7
	yJbcHMcFpnNEnh8nbZufcdpzdlGbyttanpIrWipNTCEtDyrZPZH9kMMkXUqZrMauxNU9MA
	OYGdyQZ7tGwzScWAmhOhaVfprfy4CIg=
Date: Tue, 2 Jun 2026 12:43:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpftool: Use libbpf error code for flow dissector
 query
Content-Language: en-GB
To: Woojin Ji <random6.xyz@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260602170350.261035-1-random6.xyz@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260602170350.261035-1-random6.xyz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/2/26 10:03 AM, Woojin Ji wrote:
> bpf_prog_query() returns a negative errno on failure. query_flow_dissector()
> currently closes the namespace fd and then reads errno to decide whether
> -EINVAL means that the running kernel does not support flow dissector queries.
>
> That errno check controls behavior, not just diagnostics: -EINVAL is handled
> as a non-fatal old-kernel case, while any other error makes bpftool net fail.
> Reading errno after close() is fragile, because close() can overwrite errno
> before the check. Use the libbpf-returned error code instead so the

Do you have evidence that close() is fragile?

> compatibility branch is based on the BPF_PROG_QUERY result itself.
>
> Keep the existing errno reset in the non-fatal path to preserve batch mode
> behavior. The success path is unchanged.
>
> Fixes: 7f0c57fec80f ("bpftool: show flow_dissector attachment status")
> Assisted-by: ChatGPT:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> ---
>   tools/bpf/bpftool/net.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index 974189da8a91..dba28755d284 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -603,14 +603,14 @@ static int query_flow_dissector(struct bpf_attach_info *attach_info)
>   			     &attach_flags, prog_ids, &prog_cnt);
>   	close(fd);
>   	if (err) {
> -		if (errno == EINVAL) {
> +		if (err == -EINVAL) {
>   			/* Older kernel's don't support querying
>   			 * flow dissector programs.
>   			 */
>   			errno = 0;
>   			return 0;
>   		}
> -		p_err("can't query prog: %s", strerror(errno));
> +		p_err("can't query prog: %s", strerror(-err));
>   		return -1;
>   	}
>   

