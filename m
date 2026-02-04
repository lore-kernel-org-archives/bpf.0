Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4841C84D0
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165238; cv=pass; b=MzTvdUtGWxknC23otXD0+u3gyZvFPQJJzFOPT/xf2DUo4D9/xWEufWuxqIyyGUYqX8vgmWhN1Olu/mLXjrsP9MBih0MmEoEueEH63nBGknODNQgdKwv9JlqzgX3gqTDnlthJJqNZmzTX0nCwpgw85+ot23lwIKZbpMqCkCX1OYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165238; c=relaxed/simple;
	bh=BGYBSwLSXw3GozsSaycEkBwr/A0rvU61Cqbob+qm6+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MP3v4zZtq7uNLKgDwoRoPFTvu9Ud+jSW8EqhvK2SGQLh3hlIiLWzmRSMbJKEROayaZJrScQIEa2CJxuaybXyuh038FCDKY7AEwBWZ1DIK4BAEFBkYCWX+UZDKLcJMhR2R1/JQuE6NEMMylSJq9DE7Cn2BoWawR73sfNVF7QWXew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjxGUmMV; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjxGUmMV"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4805ef35864so54250645e9.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 16:33:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770165235; cv=none;
        d=google.com; s=arc-20240605;
        b=X1y5rpxfY+eomtr2qbaGk71Rnf39ZgiFGiBuYuvriMEi4QdefqsGGQk7E4gOoAP9o8
         Bn/YfdKEpIFBcM4+6Um/KGygYY52m9CA8ayZQ50dxoi7ZmvQ6hpczKYft4UYDKd9eCvo
         07y6KXAaEwH+VFHiPH1wYVgqxH4qTKtroN58Hvk3HauaU4aI/DaafFdxCC3+AwbLB8kF
         qrU6Lkqr4h5E00gzckVHFqCEliNdthlHWZDj1bimXJkNA4kIZFk/L+nT7jKaSP6fWdnf
         ejbElwsJnl4X/IJODdpe8tzTFwdQsVmoih3Z9VmT+oV7Bm6HQSkevWQWBpZBk4qodDSU
         h1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SPVaxMJSX4AG/CeVmMqvFPaGAwqC64TXT71T62h0CPs=;
        fh=sn/trcUGTBW/ZbZ1/BJHYp2jeahFPK/jirPSfqFZYwU=;
        b=A7Jcm/O0e+RMwZzOte/b70mALYnELHA/R0ZVoENFAwZ158O0gSAm/nBZVczYjc206C
         5uhUsyIPImad3a6FEaF1ByM4ZRVNa/4/COMQ/pcooaNghi9M31rYtmSzv3ytZA0xxgXD
         vYSXTwwxgfuwrHkYC4238Oo3za43nYmSh1nudMjy7OtNqBFwbdNIVNB3d+ywlnm6gPDG
         5qOy0lVja7sqGO3p0XpC78NkJTKW6z2TImaaR8k+CGK5FjZv2OGdQ5G6B4nQ6U8JdyTZ
         knt7gBO9Mx4vQv75sbMPwTJy8i/tUgnQhBrHh1apGpIsxV5xt2qxsm6AW6M3YlQaeeNU
         babQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770165235; x=1770770035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPVaxMJSX4AG/CeVmMqvFPaGAwqC64TXT71T62h0CPs=;
        b=YjxGUmMVEp2tVQqqVOigEEv1KH2gL2jCI1gSnxN+mwhAUVT95y/j8rNPQzsV9XM+je
         46uXbatWCmha0/6JRP5i2k2BDu+/+G2jlivmiJ5QHrNrMZGtKhecTueRit9NVwRk2oXC
         /+rRNTb8D9vybS5Q72W97RwD7/pd+Vk4gyVE6j1ApfXnnkMkwW65MxJBAr0V5R+jlM7K
         +yUV+B+uVyJcYBiNrigDZYxe76y3aPuC0nHMJ27701+R9hS5UIfi8sIKvCvYmizqwwJQ
         6Ue45HiBFsRaYOxxNpSN7vnN4uHdIi66jMbkfkbafmfC28UA62IvCKlr7jQvyyuZjK/L
         +Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770165235; x=1770770035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SPVaxMJSX4AG/CeVmMqvFPaGAwqC64TXT71T62h0CPs=;
        b=RLeqm1DhiMuFG/LSHvoWtfRxhfXkDvJ1Scmp/QJ7EhawUURohYSlG6NVG0kTpgtaah
         oVQ/5agFwp1tbTQZVNXEw9mx63noQzhkbAxpTtwf1TKsKFUZvS1wQbqVpma0kpbwCBR8
         6YgRoa9qjF2uC84WFOo3jcQbboQ/DF9PmSFD994qSEvTlRTXde3Db4KpQattROMHTNg/
         OYG5kbxz3BD1tXXPfGQyYVw9/EjKaLaxI0MgL7RCWm9DvXXH1/onPxyl6m1OSBw3AJVe
         g53nqfpXbF0KRpL2cWC+jqpBUXNvFvCfnO0o2IxU7+nqeodm5gp+FBcXg6dudNfB1Bu+
         NlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUURlb/k0WY1oy38Z1DbeN2ZQ5cmHZMwK4ki4M3Nuis+VGPl7+MkHxoOMVW6CmU9P/rUBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2bfew9N1li0zP7MjoCbIcj+iKidyMEDnEBION5GLqS/ALP7w
	wTQoBwAHfZRcUkLb3vP2pjM2ktBr2nWi0f99KIa6GlJjlNLGUNo8H8eXdvcZs2xqaR9Xp5cIrsw
	DhWA8jgEFEoAIrXFTKa54qmnajh6xm68=
X-Gm-Gg: AZuq6aJe0ZnJ+z9UNB/hxvyq1M7WL8tIZ3EyedV7e1dGi/OhSw6NYB/j0QZiPYNypx7
	EWhhcGRUEauqLxEexsoBw0Sv+iM7SnXB8Y769CyKtCli37qzFfalCjrRRylifN5VNfFUtnfvtC4
	boy7xKu9IC4H423HU0q3NbSLQ54LUGyaieWe+CdwsY28X9OkFbt7UtOfvPZ6o1mCIcx1yDEhxqv
	v3Y/sl7pm4WT3o63uJj6bWXMwtu0zrouI9/agx43kSoslKbJbHBuU+qXzQn1ULJ2K6kA+Ngefbm
	po+rTVkh/lVLZqsVwECxLTPROGhNlVCdYZcWVKJYuqa19UEL/2aleNv4DosHoGycn68avcDCJ6E
	VjZgEB/oNfePbOQ==
X-Received: by 2002:a05:6000:1a87:b0:435:9d70:f2a2 with SMTP id
 ffacd0b85a97d-43617e3ff2bmr1687108f8f.25.1770165234840; Tue, 03 Feb 2026
 16:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203162746.2337002-1-arnd@kernel.org> <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
 <5f9c89fe-df1d-4eb4-b724-08f8d90fcc59@app.fastmail.com> <CAADnVQKn4xP9s_koBuP7D_eqUX0dSPwUr-dOj3mTZNTh_VxqKQ@mail.gmail.com>
 <ab709a00-3a7f-423f-9d8b-b2cd17fef76f@app.fastmail.com> <CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4VReqAJ=68PaaKYmg@mail.gmail.com>
 <0d5b64a5-8cf9-45c7-8848-ac62d3fdca44@app.fastmail.com>
In-Reply-To: <0d5b64a5-8cf9-45c7-8848-ac62d3fdca44@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 16:33:43 -0800
X-Gm-Features: AZwV_Qjc7I4LW10A_MsBK9gzCnlcGrYFPLQJ4MHmI9YKwGlTTtcByDbp2yg08qk
Message-ID: <CAADnVQ+_Ed8HgtwF5UcX2Ee2SeHU6ad31Z01Zq=2uL2qpUmgsA@mail.gmail.com>
Subject: Re: [PATCH] bpf: add missing __printf attributes
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:21=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 3, 2026, at 19:11, Alexei Starovoitov wrote:
> > On Tue, Feb 3, 2026 at 9:44=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >> On Tue, Feb 3, 2026, at 18:24, Alexei Starovoitov wrote:
> >> I also see the comment about bstr_printf() mention that it
> >> uses a vsnprintf() compatible format, which would indicate that
> >> marking the format argument isn't wrong, though I agree it is
> >> not actually useful if there are no callers that pass a string
> >> literal.
> >
> > In general I don't think it's a good idea to add nop annotations
> > just to shut up over eager compiler warning.
>
> I've tried removing these three below, which now gives me
> a clean build with -Wsuggest-attribute=3Dformat, after the
> other three patches I posted for unrelated code.

Nice. lgtm. Ack.

>      Arnd
>
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index d6ebf0596510..2fb266ea69fa 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -181,7 +181,6 @@ int seq_open_private(struct file *, const struct seq_=
operations *, int);
>  int seq_release_private(struct inode *, struct file *);
>
>  #ifdef CONFIG_BINARY_PRINTF
> -__printf(2, 0)
>  void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary);
>  #endif
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 1b564c36d721..b850bd91b3d8 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -336,8 +336,8 @@ int __sysfs_match_string(const char * const *array, s=
ize_t n, const char *s);
>  #define sysfs_match_string(_a, _s) __sysfs_match_string(_a, ARRAY_SIZE(_=
a), _s)
>
>  #ifdef CONFIG_BINARY_PRINTF
> -__printf(3, 0) int vbin_printf(u32 *bin_buf, size_t size, const char *fm=
t, va_list args);
> -__printf(3, 0) int bstr_printf(char *buf, size_t size, const char *fmt, =
const u32 *bin_buf);
> +int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args=
);
> +int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_=
buf);
>  #endif
>
>  extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *p=
pos,
