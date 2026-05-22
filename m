Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5C145FE0
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779419591; cv=none; b=OoVYbH3gKEPwvBdzv1C9Hicu0NQKNIuY9IQLZEg8fW+B0Ws8TEH2hmYIKx20P2g/c9aaNeu4Cq55sEUiuNMZodD+PxcOe4vwH5gzRr4mtL5kMRHH/3gagiZmS9CmyI0XxATGARLRM/7Vud1HPjfKm3C5qeYX0KhMEO+0eNlkuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779419591; c=relaxed/simple;
	bh=m6y7YNm4DoFExjcrmWvyl7FJPrwXi+Hy8QUwut3uhPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XHrxWRr7FSYMVpSlBVX0BKyOi4tyaaGSzNAzkYeQkcs5bt/9+6o+OZbVBNFuQvWIB3j/BkPrrDCoLCKhlnspu5dBYdgeh2lvHXyZYtwlG6tf08iu+By45ZmUdmKz44lev+US7oqqxb3uVMDOzZfDTrnRTwPPU8EsKBOC2e49KNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDQpEZaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDQpEZaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AC61F000E9;
	Fri, 22 May 2026 03:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779419589;
	bh=aFbEy6qWC2OE36mrA8nmVU8JpqmqOBf67v+Ynd7cooY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LDQpEZaSyQkSbhydDuA3xm764dwuBXMNn4jm+CrCWGbfmq7ZWvqNqW08pCkNmH99m
	 1ESWjoe1KR+cVMiZ8qn+dogtBvtcqPsP5rvarY6HILh8aK0zx2S98/EUqc9TWgxCcK
	 QUjQjWgHkZMd0rJj8OpTagP+WNQxmmnCX1htIqwO01nd+sGon+C6kdKd2XGYrTgqEi
	 KUjF4ryYc5dMB9XARoekLdK7CWja162y2rjxDVKAuqTkBxQTpoLuSU2E/sk7P5zaeY
	 hsznGlzRIcckGFUvKxIQJPqBy5y2igffRJVcoDkTVdzX3KHBDcQLI6Its0diHHMAir
	 Jasc8AO/jfnmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] net/sched: cls_bpf: prevent unbounded recursion in
 offload rollback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522025854.341647-1-jiayuan.chen@linux.dev>
References: <20260522025854.341647-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 03:13:09 +0000
Message-Id: <20260522031309.A2AC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function silently swallows error codes during a rollback, retur=
ning success (0) instead of the actual error.
--

commit ed592986d69e913d97df2ff4e0394a1bcd8686ac
Author: Jiayuan Chen <jiayuan.chen@linux.dev>
net/sched: cls_bpf: prevent unbounded recursion in offload rollback

This commit adds an is_rollback flag to cls_bpf_offload_cmd() to prevent
infinite recursion when a driver's tc_setup_cb_replace callback repeatedly
fails during a rollback operation.

Link: https://lore.kernel.org/bpf/ce5a6005-3c5e-4696-9e05-eba9461dc860@std.=
uestc.edu.cn/T/#u

> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 9a346b6221b35..d71fbf7cb407e 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
[ ... ]
> @@ -176,8 +177,8 @@ static int cls_bpf_offload_cmd(struct tcf_proto *tp, =
struct cls_bpf_prog *prog,
>  					  skip_sw, &oldprog->gen_flags,
>  					  &oldprog->in_hw_count, true);
> =20
> -	if (prog && err) {
> -		cls_bpf_offload_cmd(tp, oldprog, prog, extack);
> +	if (prog && err && !is_rollback) {
> +		cls_bpf_offload_cmd(tp, oldprog, prog, extack, true);
>  		return err;
>  	}
> =20

[Severity: Low]
Does this silently swallow the error code and return success during a rollb=
ack?

If err is non-zero but is_rollback is true, the entire if condition evaluat=
es
to false. The function then falls through and returns 0 at the end instead =
of
returning the actual error.

While the only caller that sets is_rollback to true ignores the return valu=
e,
this still drops the error code. Should the recursion guard only wrap the
nested call so that the error is always returned?

    if (prog && err) {
        if (!is_rollback)
            cls_bpf_offload_cmd(tp, oldprog, prog, extack, true);
        return err;
    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522025854.3416=
47-1-jiayuan.chen@linux.dev?part=3D1
