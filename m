Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795638305;
	b=NgEDF/bsBIR0Q2nAzKBdxt8MMJY61ONHgLz52wpuTcZmVyAAhrcGUXsIdW/m9jx7AP/l
	 AMGsjfE4rcttt5BTxSIjXe33aiS1w3F/WQWuLz/Gvjbo8XUVe5eRXD+4zcNRkL+PQrDpx
	 jast1BgWt04QgAyKmCs72zZHExmlhODTNyPR/b5n2BVTgz46sIRWNua/loj9UniLPpg/f
	 bdSFgKjhOgcy6Fp4Eem1Z+j7+ICJYNXQf+/JWfWvb2fq6I9Qp84Zglk13m4pwzAxfpwds
	 q4XY/jBeHBaiBnvkMN13VXG++O3csbd6Mc83hFYSy1Ey+oz9ts2X2vPLiA5zQl3hKlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
	b=P+B3Mqe3GkS4N1UY+7fZSxVzeJdHkuvwTJ471DcZcgnQ/UuulZ0B3iRzkQAnQai7AJ3g
	 YAPfHCkukN5GQinNhXUVAr/Wa9fwtb+P9yGPkfIPttW10XketWMvMYX7I94Sish8oYanL
	 Em0zjN/P+lqH5s2IdGpvFKtU+fXBAaY+vtmdrdrcDhL92JV2YK/kQqH6vJxnsYuKX690q
	 UBs1d2dsWGTK83Pq3Sz8wOHE8UyyDoCWYsodGufa/46ayT7e68kYMZZaf/6Px35R6gSk+
	 It6tnmkbBrcT1o3sLTGrk/i7ogGFLCQPwOwtHb8HgDm39DD7xZ1U0KUsVkwjvvaHLPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxpVsnDh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E811606A339
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 20:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E811606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxpVsnDh
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so10735845e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 12:25:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795638303; cv=none;
        d=google.com; s=arc-20260327;
        b=VE+0Jz8MLIPzbjy4pm9uTwB7kgD2Tfs9ao4fZ2WbOScS7pGULS4tRxdVSV7l1pPhyr
         pBUFXMy261nezKReSLf7gvzMiBEeDvfiDm3/YrFg+5L/tR1DvGesMM5xfXue43K/R8z5
         lHNJNlH+Xolw+73FrTuyvILQwscTCRxJcHen8JGi+NScTeAgD0lKuzpyO2WRaWzkwQCJ
         0vSG5mYyeMLDo6RsqQrey8OL0FcOfAdpRAv2scgQB7k4s3k8bre8g6a/mhMdQG8jtwJV
         GwX/NReI06hxxVUpWrodpx2cCq16Wa+AmgnqN8MKPTp1Retz7s1/IDv0qMKakc0M8PZl
         nUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
        fh=Jb4t5Dwth1/0AxG3u7Q72xHZw/GTc7gH2MEA9vRZ6bE=;
        b=XBiBpWosy+47h4tT+N+vz6wESXITL3qMdWF4mvu7YDKKXpv7h/HpNtIyUjQCMFuXbI
         VD3a5FzIw4OI1o8Wml6Gfuhc9To37SpZBhoW4oiKA+8J/IEaNSTTLNXnMF82FeSpYSGY
         LeuHZQH+O4tkBLJV17sWDOG0SZxARlnUfj0UVkWd3N2EymaNhzKxYbNXakgKmNIKv+nf
         107k13e08qX7ESnoo2aAgr2y70dLbua4qk4FcEQ3T1TgCYsnSFwklIdDLa7fpPP3cfdv
         Oi3gWRoeNGqyhZGBQOxfX+ebjXsxMR7PerwnVP0dwCANveB7vexHWj0jbnerI8r6Pmij
         aRYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795638303; x=1796243103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
        b=qxpVsnDhKpASGf9nC11h7i3rrzbhgE1Ei3PO9P37aCNXYSI78K7dE3d/HkpdwHszrk
         LY2ewZzhpWyuiXGJ9Y/kVXRgwoqcZjc+AjjGTm6sKWOe26uegothRZycWdOMEmeKaehQ
         rcee0VmCBD9LHFqBMRGKRgu5+yxn/QVPc8+S1f0ZhA8k/QuPVe7lO4kH9kZ7PLYaSPsZ
         UOhEiycW2Hi29WbdqTe9JB7fMqfgVwt5DLrziudwFU1jlESg26yCSYwEh1zt9b/mn3Al
         7ZA2LJwSY/mdKqaAvIEdHaHjwDhtcY5fLQiXuVbUxvNBi+V1wIvq+poIXwdOZVw4io/Q
         3/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638303; x=1796243103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
        b=vZ8Uqtov5Meq9AzEXzIHvpiFJrg+jkDEAEPvQ2ybA1/WwPVn9OGRJ+qrErDRkX9K9l
         pHzOZOf2nYxTE1F7DSU0LjchunmH8/vryyEWr5Bj2DmlToQ0lNB4NBCxFDGuKaepyM3Q
         skNab9jTSKCH8nCY5p/9olvz2HEC66Gea27e+UNz9U+mHl9q/z7iDfw44KlSdhRpCKa4
         n9L+ocGCz/2kQr5dr6h1FODvU+pcgM9fJS6YI0yjBpuKSWlp2EN5cd5CHz820BZKHVTA
         wg5opuR2Q5DF7CdSBkzX/aHk5reZMs4LuuE20g+j2bGgqCaa8bOfQNqq3mumiO3aB2uy
         ljDA==
X-Forwarded-Encrypted: i=1; AL+hErEmwb437OxxrZcjohD6LQSTADaDZrH06c7gL27Z4omL7vBzDjmMX1lq7vtY+zH5A2voVcE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9paxWdxt9MKZ+w+eUkO3ueR6S94SMe/tYzcFdA+cuuxKlQ5AyU
	btMGK7C3iz0FQsqWzo14W0vAEqSJxn0vydKtG7uiAQvHSjZow1yDnxCIqdIZpms8DLe5eWdWp/x
	h/+7JtG4EyXsWk10SMHfKOwIwH9aIJDA=
X-Gm-Gg: AZFdTZf6DJfS1AGGJx0i4LHoHSegRtmUwiE9t8MaqaMYYWrrT0cWRpPB1CyPe+7Ws5X
	dodwMF6x4z0EpdfXgmTnadk1x39NFG6xEHHJhwblfE086l8df+7f/twC/I75NF5PDENPAs41rJW
	Un74FZqdtStRnl2KCh5WGTgY6NqZZ7SAJETYbs+s1oDYftBJUHBO02b7WzjjiXbHx+DlbWMESSg
	QgHHQzRGu24QDxKlVwRnKUOoypT+QLSXhcoMgXo0HeKnD0RzduP7Y2+Kq/sFxi2hGOH5Q/E6at3
	QTm9+gEkMZlX4gmvlMpW5C7HEkwjn51WDa2C2sp1pQkzKdfpUEIbjYRz1S+POU3ZfBveyRw/pVb
	Cg2vGJafoS4EYfeS/txG9yJc9jlYSIf8TP3yJj0Dt3gqIyaA/LLsELhUGDQlxVWRYJDbyxECJC3
	SeQ7Ah1kJ5wsAzW9Xnlg==
X-Received: by 2002:a05:600c:4ec9:b0:4bb:6a5a:782d with SMTP id
 5b1f17b1804b1-4bb88925fcdmr394635895e9.17.1795638302754; Wed, 25 Nov 2026
 12:25:02 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com> <20261113221248.3535369-13-wusamuel@google.com>
In-Reply-To: <20261113221248.3535369-13-wusamuel@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Nov 2026 12:24:51 -0800
X-Gm-Features: Aa3M54paGFwRi6x8xvkBaed95VaPlmoDIEKWnad49yMfBgn6GjtOde1UijdiQkw
Message-ID: <CAEf4Bzb6LQmHHkvB8WBezU6YRtggycRvvA3L03mQHDr3WQM6mA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:14=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> KALLSYMS_QUERY_BY_NAME, added later in this series, needs to find a
> symbol name or prefix across module symbols in one pass.
> module_get_kallsym() walks the module list from the head and runs an
> export bsearch() for every symbol index.
>
> Add module_kallsyms_find_name(), and put the shared query struct in
> linux/kallsyms.h, so we have a more efficient linear walk.
>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  include/linux/kallsyms.h |  7 +++++
>  include/linux/module.h   | 13 +++++++++
>  kernel/module/kallsyms.c | 57 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+)
>
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index d5dd54c53ace..d31f2f436159 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -24,6 +24,13 @@
>  struct cred;
>  struct module;
>
> +/* Exact or prefix name query, optionally in one module. */
> +struct kallsyms_name_query {
> +       const char *name;
> +       size_t cmp_len;         /* bytes to compare; includes NUL if exac=
t */
> +       const char *modname;    /* NULL matches any module */

will "vmlinux" match just vmlinux? or how can one express "I only need
symbols from vmlinux image" with this?

> +};
> +
>  static inline int is_kernel_text(unsigned long addr)
>  {
>         if (__is_kernel_text(addr))

[...]
