Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749232AACB
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224881; cv=none; b=o4GO7Nw9wPNwav2xg2UhG87Pg1j9Y/Iv5H84Dh9HsytvvHb0wTX02jJC5IUu+U4w+uYgGJYxrzMwxYi4gXOo8WXZk1inAS3syFvIKaJRuqiuzswcDWYA2jt8NIzwGtF8xmpiLvjkApPMnQoC2v3jOMEAPNElFP5xKezvA7BW8wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224881; c=relaxed/simple;
	bh=XSKD4b6pJloZkP4UmqcMqBK/XxIV5X77DY1/JjQ+RB0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eLi6PyxSavvF1N7/U6xKAvawh1K1eJE/v3yyupmfxL7w4uhGb3tPA1AnmvlUiCT804i6EC9rq1Ha/TWYkwlrw6+4VAOblVGP2ngWBUiOpJHpNC7ejb/5yYIvKqHimiREu6OMnLnV7WEtHoGlIlZq9w4vyl4efGZF3Er0tSdrLT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9WfxdYt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9WfxdYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F7EC2BCB4;
	Wed, 15 Apr 2026 03:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776224880;
	bh=XSKD4b6pJloZkP4UmqcMqBK/XxIV5X77DY1/JjQ+RB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=M9WfxdYtFPXHB58u9IYlXr+L1E8sUaBtwW3EFUuAb2/sr0gBV4hb4eGhEt4aRb7Sr
	 PHEi7iA6zAht+NE04I5FOolDV67NUf+9sIBizouBEE277LufomMz2UGBMaw2g8GVhd
	 5KIBlnnBC+RyAyWZnbXqZONYEz0X0LZ87tLr6Qae5tDNnlXTztX1LOhuSvjND28gPW
	 dcW3GdfFVFi3C+NISJ7vfGER1cf53MjbCyi/Ep+3jJ6lVEHLCFrxCaxh628o7Sg0F6
	 LKIfhsYpMZrdAGFBXLhzMjUNa23cerAdtfAGHA+USPSk4NnbOf3Pr8VYeLWcaPM4LV
	 CiUetARmdFafA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: allow UTF-8 literals in
 bpf_bprintf_prepare()
Reply-To: sashiko@lists.linux.dev
To: "Yihan Ding" <dingyihan@uniontech.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415032126.1096299-2-dingyihan@uniontech.com>
References: <20260415032126.1096299-2-dingyihan@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 03:48:00 +0000
Message-Id: <20260415034800.89F7EC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Misuse of `snprintf` return value causes `tmp_buf` to advance =
out-of-bounds, leading to buffer overflow and memory corruption.
- [High] Truncated strings in `%s` specifiers lack a null terminator, causi=
ng `bstr_printf` to perform an out-of-bounds read and leak kernel memory.
--

commit 5e148b2d150df2934403df59a01d44e2a86c360d
Author: Yihan Ding <dingyihan@uniontech.com>

bpf: allow UTF-8 literals in bpf_bprintf_prepare()

bpf_bprintf_prepare() only needs ASCII parsing for conversion
specifiers. Plain text can safely carry bytes >=3D 0x80, so allow
UTF-8 literals outside '%' sequences while keeping ASCII control
bytes rejected and format specifiers ASCII-only.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index bb95e287b0dc8..b40add1cfa2c4 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -867,6 +873,14 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_siz=
e, const u64 *raw_args,
>  		 * always access fmt[i + 1], in the worst case it will be a 0
>  		 */
>  		i++;
> +		/*
> +		 * The format parser below only understands ASCII conversion
> +		 * specifiers and modifiers, so reject non-ASCII after '%'.
> +		 */
> +		if (!isascii((unsigned char)fmt[i])) {
> +			err =3D -EINVAL;
> +			goto out;
> +		}
> =20
>  		/* skip optional "[0 +-][num]" width formatting field */
>  		while (fmt[i] =3D=3D '0' || fmt[i] =3D=3D '+'  || fmt[i] =3D=3D '-' ||

This regression wasn't introduced by this patch, but there appears to be an
issue in how the return value of snprintf() is used later in this function.

When parsing %pB or %pI specifiers, the code formats the argument into the
bin_args buffer:

kernel/bpf/helpers.c:bpf_bprintf_prepare() {
    ...
    if (fmt[i + 1] =3D=3D 'B') {
        if (tmp_buf)  {
            err =3D snprintf(tmp_buf,
                           (tmp_buf_end - tmp_buf),
                           "%pB",
                           (void *)(long)raw_args[num_spec]);
            tmp_buf +=3D (err + 1);
        }
    ...
}

Does this code advance tmp_buf out-of-bounds if the remaining space is too
small?

The kernel's snprintf() returns the number of characters that would have
been written. If truncation occurs, it returns the un-truncated length.

Since the code unconditionally executes tmp_buf +=3D (err + 1), truncation
would cause tmp_buf to advance past tmp_buf_end.

On the next loop iteration, the bounds check evaluates
(tmp_buf_end - tmp_buf < sizeof_cur_arg).

Since tmp_buf > tmp_buf_end, the left side evaluates to a negative ptrdiff_=
t.
This is compared to sizeof_cur_arg (a size_t), causing the negative value
to be promoted to a large unsigned integer.

Could this bypass the bounds check and allow out-of-bounds writes into
adjacent per-CPU memory?


There is another regression not introduced by this patch related to string
truncation.

When formatting %s, the code uses bpf_trace_copy_string() which internally
uses strncpy_from_kernel_nofault():

kernel/bpf/helpers.c:bpf_bprintf_prepare() {
    ...
    } else if (fmt[i] =3D=3D 's') {
        ...
        unsafe_ptr =3D (char *)(long)raw_args[num_spec];
        err =3D bpf_trace_copy_string(tmp_buf, unsafe_ptr,
                                    fmt_ptype,
                                    tmp_buf_end - tmp_buf);
        if (err < 0) {
            tmp_buf[0] =3D '\0';
            err =3D 1;
        }

        tmp_buf +=3D err;
        num_spec++;
        ...
}

Does this code lack a null terminator if the string is truncated?

If the source string length meets or exceeds the remaining space, exactly
tmp_buf_end - tmp_buf characters are copied without appending a null byte.

The code advances tmp_buf +=3D err but fails to manually append a null
terminator.

Later, bstr_printf() unconditionally calls strlen(str_arg) for %s.

Because the string is not null-terminated, could strlen() scan past the end
of the bin_args buffer and leak potentially sensitive kernel data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415032126.1096=
299-1-dingyihan@uniontech.com?part=3D1
