Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE622BEFEF
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361922; cv=pass; b=pnX0bqftk2YhTYL5ZV05KH/351PIVZCiA6PuJDb6r2Q8DCDcQjSQbEUHYQbb+X18M4aW2jZdh/TLn/Um6erL4GCcNWhFNV+N/tuEcyVx2/d5OSy9B8Mhec9YHHE25elx+11Bh6NGT8DdD45+xJ6ke9tu/Jyu+JJ/mI24/We6qgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361922; c=relaxed/simple;
	bh=i3n/pZjO11b8FZrngtzK4vjoUhf/PA1KucrD+egnHyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqV73aNDubI/dYUnu3+hnZvad58yfTJoypF9W7gmaXLgDlLYaOyYx4MqQ0kWQlxI+oCA1NCV0cWI2vJxqZHJovoUP9nzFJXK2RO7opDENhgmPzggTEI27jVqHsac6GrakBTHDoJ4X2JYjzHYBOL9xkXEB209/oNghzSytEiu7sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLG9XE/2; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLG9XE/2"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6611669cd16so4622284d50.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 11:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783361918; cv=none;
        d=google.com; s=arc-20260327;
        b=Qe8pDytx8q1WifQulkL2mXUtTZSCYt2Kpw4/Y+IbpxaJuGKuLZ82+eRxWWTAO9zBfs
         t4TexKWOVXUFtpgNSdERGtUNQn/GJJf/mZ1o2OVtj5cSur4eSpxlfSQObeVyygDcYL0P
         CDtEMt29HtNfafi7LHErn00yR72sByCwh05hGA7SP/TJWafux6PoNlduSw+mumARzp6i
         BCl8tv3Rk8nzLoeQzZp04/MuuUvG6odUazwzksfLWl7Z3juFKK6Nop7f1m5R3iJB5ksP
         RK9UOAHxn1looOSEa0Q+NqT0E0sg8oTpFLHWW1enA94yR8qAWzY9zPFcCk49fWRgwwJK
         EEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gbuqyH3I898LEQWDxhl/FzpS6xH0Rf6DtxQG5lLXLNk=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=md/BUARYteLE7rwDaH0Nv0ILYfyLp9ZBcmza3xgsenpXGxfObzEFaIKRsn5WiiUybS
         9zSCVnAGdVIhdk1OnhddchfnQFN1G/3RIb1VIa7xkj464bNUAQsJRfr7BxmJ1IEKdm3K
         XcSQxI/NF0eYPMhnHYC9/Lkiq8pjtkv2E5QKezLkXtgClk7xQMtGdSuS6YybPX1rZbGu
         gCB5477U/CaVApBJHvb+pWQ8ShwV+ccwGyrl0wpIgtZ4SeEnnWLp9PVSiCZl/cOLVE5D
         sDKvRqw7lT0yLjwUxEL07jWBqijVn58jMoxFp5Ifzg7plPCcMli7ik3x40S/60bMVCsn
         aVPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783361918; x=1783966718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gbuqyH3I898LEQWDxhl/FzpS6xH0Rf6DtxQG5lLXLNk=;
        b=PLG9XE/2D31Z7JqsjFqmb5SkjM/QK2t1XEe9dAGgSN+HO5jxcOulwa1xbOu8Pr7Z7Y
         a0TLnzf2JCkPuzuzP0mZCvR0QDC5FvkiQcPEPAvTHjrb0WyLL7H7DtAlI8DM1AF8KBow
         B3KlCCc8L43gkY9qed/NW16ix2qrkDXB9w96ymd+VAhoSZcatGI588zN6497++KU5PYK
         MjLQZNnxsZFQc2bPl9Nr5bd9J0mOwn9Zsm2AclGopf9LwLkMESCpSL4FsM77mrF078rv
         0Gsrq0VWDePWLT9jKyACK2v+lzmvA+RTmmgtFSYC6urNfE4r6Nq4aNhE8OOZ3oq48lbk
         3ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361918; x=1783966718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gbuqyH3I898LEQWDxhl/FzpS6xH0Rf6DtxQG5lLXLNk=;
        b=WYpZF8UvBrPZTnyK5uw74FwDdeYSLibrawb0CC4oMsstA9t5Gwvzn4nfiE1njqN5Z5
         l8421KhiOgzWuuEIHBnAcezIGmWk3NL1ATjP3eHHqGpmlfolfsxeboFJ/BdfHW9aNXr/
         mgy/Wjbj/c2j+GK/Ic38aLbGH+/HT6JLjlI1IkhyHoBRRIxUlPFD+mf1sucQEu2uYk3u
         MAaMTxLbIR2lPiww6P4GyJXkqBFPSinnOD9hremo89PPObnesIL+xjG+wgv9GRckozcG
         gEMHBGKt3d47XtTqZv/m3Dej3rywjSfdvHhBQaO2cL2wswLVQvYb7TmZ6ZfzAwTJekR0
         GH3w==
X-Gm-Message-State: AOJu0Yxn/ixhCk4fHu5AtGMCVX3s/kWfys7/20XUqWsHIgXUguGpuSR3
	t22gvw/TFGEBcz+mZe3TB31v/nrId8bivqHmmZpbKC5Tath7TPAZxxEL1+0nkBX5LZTqovcrU36
	CcPeezO0mp/Ug5DISYG4AcKEl03BLMvg=
X-Gm-Gg: AfdE7cmCvAbF6FO1DCXKfrM0/XzsvgI1aF/wbSjKSJufKaC5VF7w4coeMDAlqb6RqQw
	33lTVA5bttP8Fx6+8Ms5iBTuQYPla5bp1MAHeRFRAK0p9I6qD7Ygfxo7evWQA6MMJ4ZL3pSii6z
	PIq0GTXRsKcRLkXnyTy0rhi4tW8udUcQvI+F/23vbVuTzgOM4qVVGHlQs4aK2qoXXbhc6Ud5xOR
	2m+Bz3Mtzlk5HhprfYkuzB12KlR5IMolEGD62vyOAYQBRmyGnCTljiOI1F81C5mL7sqfPUc
X-Received: by 2002:a53:d34e:0:b0:664:f064:f66b with SMTP id
 956f58d0204a3-6677fb7cdfbmr1163754d50.26.1783361918169; Mon, 06 Jul 2026
 11:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-16-ameryhung@gmail.com>
 <20260706174721.14CE21F000E9@smtp.kernel.org>
In-Reply-To: <20260706174721.14CE21F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 6 Jul 2026 11:18:26 -0700
X-Gm-Features: AVVi8CfeDjKaihLzFTjCW1uH4GWTKlKUD96ZQGIhYLxEV0t3QQ8NK0F3dtWBtwY
Message-ID: <CAMB2axNUmeYi9nvRQPhLn-CEJACr4CfOXTHWzTW=HWst58MqBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 15/15] selftests/bpf: Add test for bpf_tcp_ops
 header option hooks
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:47=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Multi-line comments in the new BPF selftest program do not follow=
 the mandatory BPF subsystem comment style.
> --
>
> commit 0974a803b9e5fed2b4e8c0c5360735a19cae9901
> Author: Amery Hung <ameryhung@gmail.com>
>
> selftests/bpf: Add test for bpf_tcp_ops header option hooks
>
> This commit adds a test for the bpf_tcp_ops header option hooks. It uses =
a
> struct_ops program to reserve, store, and load an experimental TCP header
> option to ensure the parse_hdr, hdr_opt_len, and write_hdr_opt callbacks
> work together correctly.
>
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c b/tool=
s/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
> > new file mode 100644
> > index 0000000000000..46618a604d965
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
>
> [ ... ]
>
> > +SEC("struct_ops")
> > +void BPF_PROG(test_hdr_opt_len, struct sock *sk, struct sk_buff *skb,
> > +           struct request_sock *req, struct sk_buff *syn_skb,
> > +           enum tcp_synack_type synack_type, unsigned int *remaining)
> > +{
> > +     hdr_opt_len_cnt++;
> > +
> > +     /* Reserve TEST_OPT_LEN bytes; the helper decrements *remaining. =
Stacks
> > +      * with other progs in the cgroup hierarchy.
> > +      */
>
> [Severity: Low]
> This isn't a bug, but does this follow the BPF subsystem comment style?
>
> Multi-line comments under BPF-related paths should have the opening /* on
> its own line.

[...]

>
> > +     bpf_reserve_hdr_opt(ctx, TEST_OPT_LEN, 0);
> > +}
> > +
> > +SEC("struct_ops")
> > +void BPF_PROG(test_write_hdr_opt, struct sock *sk, struct sk_buff *skb=
,
> > +           struct request_sock *req, struct sk_buff *syn_skb,
> > +           enum tcp_synack_type synack_type, __u32 opt_off)
> > +{
> > +     __u8 opt[TEST_OPT_LEN] =3D {
> > +             TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
> > +     };
> > +
> > +     /* bpf_store_hdr_opt() takes the program ctx (the kernel reads th=
e
> > +      * outgoing skb from it); it appends after any options already wr=
itten
> > +      * in the reserved window, rejects duplicates, and confines the w=
rite to
> > +      * the header option scratch. Stacks across progs in the cgroup h=
ierarchy.
> > +      */
>
> [Severity: Low]
> This is a similar style issue. Should the opening /* be placed on its own=
 line
> to match the required multi-line comment format?

[...]

>
> > +     if (bpf_store_hdr_opt(ctx, opt, sizeof(opt), 0))
> > +             return;
> > +
> > +     write_cnt++;
> > +}
> > +
> > +SEC("struct_ops")
> > +void BPF_PROG(test_parse_hdr, struct sock *sk, struct sk_buff *skb)
> > +{
> > +     __u8 opt[TEST_OPT_LEN] =3D {
> > +             TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
> > +     };
> > +
> > +     parse_cnt++;
> > +
> > +     /* Look up the experimental option written by test_write_hdr_opt(=
) in
> > +      * the incoming skb. For an experimental kind the search matches =
on the
> > +      * 2-byte magic in opt[2..3]; on a match the found option is copi=
ed back
> > +      * into opt[].
> > +      */
>
> [Severity: Low]
> Here is another multi-line comment that starts on the same line as the op=
ening
> /*. Could this be reformatted to align with the modern BPF comment guidel=
ines?
>

I will fix the comment style.

> > +     if (bpf_load_hdr_opt(ctx, opt, sizeof(opt), 0) < 0)
> > +             return;
> > +
> > +     found_d0 =3D opt[2];
> > +     found_d1 =3D opt[3];
> > +     found_cnt++;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706171918.31=
7102-1-ameryhung@gmail.com?part=3D15
