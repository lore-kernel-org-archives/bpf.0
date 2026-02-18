Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3E345758
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437295; cv=none; b=gbmsCRnheUIulxMQQgU/E5EayKidRgU0CCA3L6h11PGS+Ic3F4UaCpeWu1v4jR/072gBlwG65rK1i3WMm3lBb9kAj+bRNTAfoXeEy1GCUY9Kw8jfw154oI/lqiZ75+dHzPiXG4u+GFDlpp37OpZLxS+8lBUuOMdKTXj5SR2m3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437295; c=relaxed/simple;
	bh=rKch0kRj0u3rzgUvuVldCISKwo/O+KjKNZNd9kZbcig=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cTY0SnRZ7XjVHK7pr/xZisYxqRjaApFW93vpkSxFgYpMC2H/wWtirArhoLbx872f5xWHuZ8FWgcVdQ3vWmN4m88dEFb64PXXfsHylzZNtWAXIk4O/OxZ+KQrPFQ+/aWm3mKj4HW+u3xCLYZCTW/iNXo6npnI0SamDbiHeDZaxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FBPoWGU5; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FBPoWGU5"
Message-ID: <53f7ac2f-3e7f-485e-ae46-040518ee7610@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771437290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zj0B6sx+G+hC9kwoVMhqvhCiUhFrZiKek5P+ahXWj4A=;
	b=FBPoWGU5Ez43pWLkpLG7Wa718ESWt3CsBgMAn/Lib61PkW29AYsTFRB7WBp6VH/PMbfyZV
	5rsDWSi9Yrx8KY0q++t05sId0VnNkIN8HzUdTwwKii824Pu0UUmkEzvUU9J5Ji+xQ9b607
	j6ZvkzGFAn+nrtiJL2P+JyZgGq4Ykwc=
Date: Wed, 18 Feb 2026 09:54:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 09/15] selftests/bpf: Fix double thread join in
 uprobe_multi_test
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
 <20260218003041.1156774-10-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20260218003041.1156774-10-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/17/26 4:30 PM, Ihor Solodrai wrote:
> ASAN reported a "joining already joined thread" error. The
> release_child() may be called multiple times for the same struct
> child.
> 
> Fix with a memset(0) call at the end of release_child().
> 
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 2ee17ef1dae2..be6ff1d4a75b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -68,6 +68,7 @@ static void release_child(struct child *child)
>  	close(child->c2p[1]);
>  	if (child->pid > 0)
>  		waitpid(child->pid, &child_status, 0);
> +	memset(child, 0, sizeof(*child));

The CI is failing because of this change.

Apparently, there are asserts on child object after it's released in
kick_child(), so we can't just memset it (without changing the test
logic).  The previous version of the fix [1], resetting only
child->thread, is more appropriate I think.

I missed this because uprobe_multi is in DENYLIST.asan

I'll wait a bit in case there is more feedback and send a v3.

[1] https://lore.kernel.org/bpf/20260212011356.3266753-10-ihor.solodrai@linux.dev/

>  }
>  
>  static void kick_child(struct child *child)


