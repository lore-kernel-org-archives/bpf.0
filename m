Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5D86329
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485295; cv=none; b=TW6PxXB0ReBYUiZmepNhzoKTWSLKPvYil/GszrS1hJUcy9LAc08Lnu8mItwVmiyvIU35Hmjl2v+LEgQaGLJtMAjaVVE8LAg+O9serzVTbrJJgWlvgvQIv3qnYWhAclPcCvGmcRWA6gInTNWLEiAqdUdHjUpIj95wW3IXgi8Nd+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485295; c=relaxed/simple;
	bh=/3mYuMpih6h7o89GWFuy3MkfmF1FF388AVeQ64/C8gc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLwZSX5Z7l3DArIc9a8mieJFOrKKnhNXw8pOzHY+0Hgrl2RljMWaj0MF0gP8BPqc15ONvc0MIbSKfoOK6q76Zfl77IeuOhXm+ryL4BOTN7xxRnC+NNh3eucc3gJsf/FCjyIbGFdP9uquOdIZCU3h1s5VpCIMbQHrWAxhNQ6NhsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjGwgKTT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjGwgKTT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903fd19957so17798635e9.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779485292; x=1780090092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kDZsLCYDn+uHPa1sJ7xx5w7pXVEbnPStdK+Lr9CPDE0=;
        b=mjGwgKTTuLsa+XKqQr8gSFyBcVSm0LNwsgrJR27WrgdhM/AHkdBfOS0Iz5mxNKqLLn
         ZPmVMkGKhj5XE82//xFMEi+FIkK9OSdMq3OlX/jefxhU23kC1k0ZWfXnW0l3MLzmCzUd
         Ue7ZLyCOfOBpUoGzHISxUFVbB5QIgI9Xom1wvlpntFv3JbAv9qbNZp0C3Zj9q2Gb6qjj
         x8XD44kBdSojwKoCQiFJ4dWbeDc2L0pP28t8vxtCBdFsBOcLKEpeOTW0uEevIfkM5LNF
         4/kE1SWcpmjaVJkapCDYiuCCW8MIjfVIsLO7OCZXqNpU8Jb87G3JydXLxFuhnVPiKCJV
         T2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779485292; x=1780090092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDZsLCYDn+uHPa1sJ7xx5w7pXVEbnPStdK+Lr9CPDE0=;
        b=bry3UCpk0CKstzHbKXv69yX6YA0E1OVQnfaCHlD4oJ3fk34N6jlgpZtqMgIKRUDktu
         1SqWZykjvfVaBpelCVDwvOsSY0fpgKRS9WdbHKx+H7kIViCCRBV4ddq7824376CJ6rfy
         K3hbwxf3Ypjsi0cX6lSYVoR5eSALXP3RfES+n4hUnO66yqpV3pgw4uvjsTlwPPW7MtCs
         m5suLaMjHmbSur0MwBA1zm1Eq2vTb1wyyRl0hN71QoTKPmAB96CMujRx8CgrMbhBNSpJ
         6IV0PS98e9Jna6LhZ/T3ry/cLuYb/3jn/0ikHOhf+yvJ9dj/5I+t801+nxS2JOduY2a9
         NmCA==
X-Forwarded-Encrypted: i=1; AFNElJ/cKAVl4OKKvKx3I0olFD4HfaLXWfn1IlDhqYfkYtNrBN+8sgvl/Vcm65MDWGPChqH35lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhKwBf/iYzFQ9XT/JcO0IvcF/f8Xzgno3kA4aeIk6tIP97Xuqf
	4Ybudm3rfy0yjgCaB1c8S/lrARZ0ga8z4FcDn2bjkcrAIisHhOSSnhCN
X-Gm-Gg: Acq92OHPWyBLhOeJ6gpD8KpLeM6Tzh5ndc9NZ+4F/ZHUi1IMuaT1/5eBbsdIUVu2W3t
	myrjSQxyPbtGsbHOjA1Y++P6Iv/73GVN4BptkbJ6bZiVDFQEa8+0Mk+Z/KeQxP6/ckQFTzGdGFP
	+Uk6PTQEP+icno19KYILtxuJqecCd8ZMrKJ4xhJD1gV2mUe9WCGwu3pbDn/1NU+HDjOC/Q+GR60
	5P69vOS+bq6oWNDpFlGqVQjPkrZ8aNZZ9x53Hzp2N4ozWA+8NBzvdHkeaiEeC7S3UKKcORZVgjB
	v13TxryXV/mFiou9+IhOCQG1MpKcuPY5XBqkPxGDcYMZjTms9t1q2hiPK7puvBnBM6jwL6T5nwR
	SufczOzILuEUCtuJvLUp36wCLYTJ67uko2E75zVROJ5u9Rm+WHV/lqn9YoYPJp9oUJyiGgaF9h7
	ej39e+mtyq0WxgkXN9nJEdX/t+oNjGTDw3
X-Received: by 2002:a05:600c:35cf:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-490426bc737mr85243735e9.19.1779485292233;
        Fri, 22 May 2026 14:28:12 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454db285sm58807585e9.5.2026.05.22.14.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:28:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 May 2026 23:28:10 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 05/12] libbpf: Change has_nop_combo to work on top of
 nop10
Message-ID: <ahDKatbb_ixUY_XF@krava>
References: <20260521124411.31133-1-jolsa@kernel.org>
 <20260521124411.31133-6-jolsa@kernel.org>
 <CAEf4BzY3bV+gkA4fRm=jzaTowG1QtXogLDOKkG3CrR5EWzDPcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY3bV+gkA4fRm=jzaTowG1QtXogLDOKkG3CrR5EWzDPcg@mail.gmail.com>

On Fri, May 22, 2026 at 11:52:56AM -0700, Andrii Nakryiko wrote:
> On Thu, May 21, 2026 at 5:45 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> > fixing has_nop_combo to reflect that.
> >
> > Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
> > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/usdt.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index e3710933fd52..484a4354e82b 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -305,7 +305,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> >
> >         /*
> >          * Detect kernel support for uprobe() syscall, it's presence means we can
> > -        * take advantage of faster nop5 uprobe handling.
> > +        * take advantage of faster nop10 uprobe handling.
> >          * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to speed up uprobe")
> 
> Would be nice to add commit that switches nop5 to nop10 (but until it
> lands hash is not stable, so, hmmm, maybe we'll land this patch
> separately? send it a bit later to bpf-next?)

hm, I think that would affect the subtest_optimized_attach usdt test
which depend on this behaviour, will check

jirka

> 
> 
> but otherwise lgtm
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >          */
> >         man->has_uprobe_syscall = kernel_supports(obj, FEAT_UPROBE_SYSCALL);
> > @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
> >  #if defined(__x86_64__)
> >  static bool has_nop_combo(int fd, long off)
> >  {
> > -       unsigned char nop_combo[6] = {
> > -               0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> > +       unsigned char nop_combo[11] = {
> > +               0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
> >         };
> > -       unsigned char buf[6];
> > +       unsigned char buf[11];
> >
> > -       if (pread(fd, buf, 6, off) != 6)
> > +       if (pread(fd, buf, 11, off) != 11)
> >                 return false;
> > -       return memcmp(buf, nop_combo, 6) == 0;
> > +       return memcmp(buf, nop_combo, 11) == 0;
> >  }
> >  #else
> >  static bool has_nop_combo(int fd, long off)
> > @@ -814,8 +814,8 @@ static int collect_usdt_targets(struct usdt_manager *man, struct elf_fd *elf_fd,
> >                 memset(target, 0, sizeof(*target));
> >
> >                 /*
> > -                * We have uprobe syscall and usdt with nop,nop5 instructions combo,
> > -                * so we can place the uprobe directly on nop5 (+1) and get this probe
> > +                * We have uprobe syscall and usdt with nop,nop10 instructions combo,
> > +                * so we can place the uprobe directly on nop10 (+1) and get this probe
> >                  * optimized.
> >                  */
> >                 if (man->has_uprobe_syscall && has_nop_combo(elf_fd->fd, usdt_rel_ip)) {
> > --
> > 2.53.0
> >
