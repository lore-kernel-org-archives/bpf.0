Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701238;
	b=wZXwRXWBnpgsEjb8qCDaoBKBklnihHw4OoSxLkUfcqV7TuI94xyMY1eUa8RG0OoRHD3a
	 faB1nAJFcj1XOOaEdqlYcxjHj3CwjBN1EmurKd/0zlXFrKO1oP8nfsAjerCqfYbcnVslP
	 xJtuVbXJwu937lxcDUZ3zgFCgGHHHIvVbjsfDtFU5NTVK4GcCgCYxDqEn0wDS080cBROi
	 j9zc6rlEBXSwjDqghCcfvccgF8Zqb535FaTBf16hOdNBffRiHqjNEFOiqpT5HOKDseLzu
	 BLWNGbljwcKYrvvZVXByVD/cWfGtUXB2DUMgMQdg7BlIPDHGy3rdMBTxdeOgFwu8m8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701238;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=JoSCXScv77vyoI0hBfGLY8ItXFyh6lZbkJUObsT+H+U=;
	b=qJGqcKyGqabdCTPGLC5n9l82Z6aiqZX6qYbrO4G1sRsRoI0m4hXDgDSP5a1mi41pkrni
	 Lwh2HSEGxCYdBkwEjbQlG0MfNl9dPHiDWgmHRAeBowKCtsJWJ+CyfkW/yO3Oj8AfNCmd5
	 biTKOG0hz7iECn385SPv5QapE4IQD6m7WDjVa9xD287wc77jtwJg90dln82rG+aVPFj2C
	 fJJp6JjzysF0FWGvnUDaUm5biBSCoxw/oWM8tmtRtvs8yUGUGFb5tq8afqoLHz2Qhtmk7
	 8yeUYtFBJVezHshC/ho+OkTrNS3tnFwlrdIy8sV6XHv/vdYx0rmQMClTndZHeNB5Jvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8HiIfKQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BF606A329
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 00:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8HiIfKQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A0A1F000C4;
	Sun, 15 Nov 2026 00:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794701238;
	bh=JoSCXScv77vyoI0hBfGLY8ItXFyh6lZbkJUObsT+H+U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=B8HiIfKQjXbeqzi2H3jL4vgVtTCeZVe2wg4L9GM+lgqSQykNpS68y0atAfGONsMD3
	 nrCVsSiffJv7in/511a+1Hm6aj7w2a565HvG5IS6spS8cyiNFOBQc6FzT5pVhEp8wm
	 TWWJEym5CZ0EemOPNQilGDmbEP+W9bFMWIb/yssp0bC7j37pnkl9Yr5S44fNsryP1i
	 8Jt1HXaJfxrbMftOrtvSN6D12+IhnI9omqcu+PK1d7rnSqNvin6VfV/TGzTHxg0i1q
	 tAXMAY131777m1mAcLIMlBCXi00Pyj3j8xml3ay9sb5MBpO18jxV9fnxeAnUdQTDsq
	 MMfWIGICb66JQ==
Content-Type: multipart/mixed; boundary="===============1528189939381649837=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <037924fd7a38627faca49c154a7def49f2f6e40f648b555e75068543f35f27b4@mail.kernel.org>
In-Reply-To: <20261114232754.2732901-1-alexei.starovoitov@gmail.com>
References: <20261114232754.2732901-1-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next] resolve_btfids: Don't list -EBUSY next to -EINPROGRESS
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,dwindsor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 15 Nov 2026 00:07:17 +0000 (UTC)

--===============1528189939381649837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Don't list -EBUSY next to -EINPROGRESS

TL;DR: The -EBUSY/-EINPROGRESS fix may be incomplete: async is only detected
from local constants, so functions getting -EINPROGRESS from callees (e.g.
sec_bd_send) could keep -EBUSY in fmod_ret tags, possibly hanging backlog
callers.

> diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> --- a/tools/bpf/resolve_btfids/fmodret.c
> +++ b/tools/bpf/resolve_btfids/fmodret.c

[ ... ]

> @@ -82,13 +88,16 @@ static int cmp_error(const void *va, const void *vb)
>   */
>  static bool format_tag(char *tag, const int64_t *values, size_t nr, __u32 size)
>  {
> +	bool async = false;
>  	size_t i, n = 0;
>  	int errors[nr];
>
> +	for (i = 0; i < nr; i++)
> +		async |= (int)values[i] == -115;
>  	for (i = 0; i < nr; i++) {
>  		int error = values[i];
>
> -		if ((size == 4 || values[i] == error) && means_failure(error))
> +		if ((size == 4 || values[i] == error) && means_failure(error, async))
>  			errors[n++] = error;
>  	}

Is this fix complete?  The comment on means_failure() says "ASYNC: the
function returns -EINPROGRESS too", but async is only set when -EINPROGRESS
is in values[].  That array holds only the constants scan_func() found in
the function's own code that reach the return without an effect:

    /* fmodret_scan.c:scan_func() */
    if (insn->kind != TEXT_MOV_IMM && insn->kind != TEXT_SELECT_IMM)
            continue;
    if (flow->reach[i].path == TEXT_EFFECT_PATH)
            continue;

A function that queues a request on the backlog and returns a local
-EBUSY, but gets its -EINPROGRESS from an out-of-line callee or after a
void callee that takes an argument pointer, would keep -16 in its tag.

For example, sec_bd_send() in drivers/crypto/hisilicon/sec2 has this
once sec_alg_send_message_maybacklog() and sec_alg_try_enqueue() are
inlined:

    if (ret == -EBUSY)
            list_add_tail(&req->list, &qp->backlog.list);
    ...
    return ret;

Its only -EINPROGRESS is "return -EINPROGRESS;" inside qp_send_message(),
a static function with four call sites that GCC -O2 is unlikely to inline.
Then values[] is {-16}, async stays false, and the tag is
'bpf_fmodret_retval:-16'.  sec_process() treats -EBUSY from bd_send as
queued:

    ret = ctx->req_op->bd_send(ctx, req);
    if (unlikely((ret != -EBUSY && ret != -EINPROGRESS))) {

so an fmod_ret program returning -EBUSY there would skip the
list_add_tail(), and a MAY_BACKLOG caller such as crypto_wait_req() would
wait for a completion that never comes.

cc_send_request() in ccree looks similar.  Its -EINPROGRESS follows a
void callee that takes the drvdata argument:

    cc_do_send_request(drvdata, cc_req, desc, len, false);
    rc = -EINPROGRESS;

When cc_do_send_request() or enqueue_seq() stays out of line, that is an
effect and the -115 is dropped, while the backlog "return -EBUSY;" after
the inlined cc_enqueue_backlog() reaches the return on a clean path.

Whether a given function is affected depends on the compiler's inlining,
and the counts in the commit message cover only vmlinux, not modules.

Could async be decided from something other than the effect-filtered local
constants?  For example, by also looking at the constants of direct
callees, or by not filtering -EINPROGRESS by effect path when computing
async.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43655020416
--===============1528189939381649837==--
