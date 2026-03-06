Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C5A36C0C0
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772768352; cv=pass; b=g9Tg6QdzP5GgpgonGU7QY3geioqfL2UNVWLReEXz1ZdMOcvmqEUiTvdcs3dwfQUs1l5pY6uyHN1YtVER9yfdmev5Xhw33UAg+J28BZG9ZLpkIi09HDYujdVJM6x5+B/5EqPv/2G7QjwTTVzwLF1dLHCOJLqFPOmrm91hN1eBif4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772768352; c=relaxed/simple;
	bh=BsPVk4AA5AREkMAlNOQRf9PtN6u8ZwU5nqjPkF7hZZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/UQgrdILB5POXjViYSVMHDtO0EdtxPuYla6d76wHoY11PtoZ5Q2EI8s2ZR+0y2kyz4aXgRS1yxlAdkR0o7rbUfSPqlVqu3aTQPfhj9B3xMCAoCexm/TIn9U1ta0IGdlOI2XdycsrsJrlok4KXOka0Y2s0t9EVAbDwDkM/3M69s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjpxlyTc; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjpxlyTc"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so271499f8f.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 19:39:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772768348; cv=none;
        d=google.com; s=arc-20240605;
        b=D8jtPrrubGKnD5O7D6nBpYtUKkt5lMApW33baI7HAcywnplqs6uk64jtt8JuGkhl6c
         Nid0OCEkhSEP8JgCKr38dZ5ma/+DI+n33ny+tBlDvbZQMuQKUFrMbRr1OTXdDpjPtHYx
         k7/2Ha7IKdpSbQ/nh2p7vpEiNZFpYCaLo2SB1T3LRZrI7GcYDnWQV3QFwcgIKE78J1S0
         2AtyvA8uaXLiE3DFDNXqwIMLb7U51c4P+RB0XrSXMzrnbdLSChEqSYhdGdDPCRPIZYLg
         hYEKuvvWThgWTxneHBCUBRyBBJrF91XQcjwVvbZ6L227JtN8qORooqEJNqu6nLnczYcr
         NcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nwC2kCqnOD3EoEeZPMfzT+GZSfS1GGGMZMG8rJ6/lOo=;
        fh=pnOdYLR1v2lPBSlHCh5fCDDIRiNq2U0ITDRyOiiAjss=;
        b=HIFFE9StX5IJ1eTLjkfPL+8/zlltxfY8Cm93y+vbL+rvBJRd5/fj6uZ1UNF57CBr5y
         CEsczDNv74mGiPcHeZRPAHsqOqbcKQLUmlN0W8oBM+bf0l/4wiBaFG2bDICtli2ZcupT
         dCcIRGx2K2BhmuYWYzZ29jubVMy1f7ahykqoVg+hq62jqemRinwZCXicC/qlePDYoBp2
         +4+0dWU+JCwtCrkt0JtEfbW0izn0VaD/S0YQusmoqyYtoPHejuaGaMhDeQz6v50jM821
         Cu2kLknvVJrnPe4MyfNP/O1a2skj6Z5maBLNZ0e0hx9uwt/3wCiEphVGfHeneuFx257g
         j4og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772768348; x=1773373148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nwC2kCqnOD3EoEeZPMfzT+GZSfS1GGGMZMG8rJ6/lOo=;
        b=hjpxlyTcuuP7ciBGWMPalbeZ3HLY49uENaR/qfJAApwcXYInufhHFXBrHra6XOgToy
         yHPtceuS0SdSd+f26qok2v6N9EDQVEvSabqGOh36UeeTH7fosjzWyGBCxtbK4/ozXFjY
         FqHqtQ+1BsmVvkXBPbT87YDBuWtxwhynZyGFWYQvn5BqttFv2bYLFb0wLD6tU4vwGHoR
         iuHZLtC9+xT3M7fvhfX4fdIjoZAzyJIZARp2clRlx6sJqTZnhi8XRTydulkrBiEBVn1E
         5L6WdYaiWtv3buVvhM3ETpI56uootTeOVcrx1fzVxgwStRe/EwKx9kSXRWcFGL6yF/Og
         rZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772768348; x=1773373148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwC2kCqnOD3EoEeZPMfzT+GZSfS1GGGMZMG8rJ6/lOo=;
        b=hks4+3kgIsm/J7PWTVcULd4PwzOj6XUh0FaO0pCHJ7gwCHuE0svbU5onnpVV44CdIO
         EvfHglU/9c8EZZIwK8Iipg6lcMeW/+HIcjuJfl1iFVk6q3rRSFIYZDok1ovlqMXCtBzd
         crqVQXv5nBhyNUKiegdSRNzQdFGdfP26G1SpBHtHVN5+rf/KJSjVENTDg6b+dJi/bTWP
         oFWGFfk/ZVAAZ8NL/7dJx1bKPohu4K2CEC7BSUzBu6w9njW8JS4f/wNL/tSruPwqeQ9X
         /3pqk4zigxqFefe8A9b/S1dPC5WUskyRRgpgitCcewMPdhb2SV+60OzqHtdXBulzuFj6
         aEvw==
X-Forwarded-Encrypted: i=1; AJvYcCXghHUAZ2GDpnikDEAFcAgkpp4Owin1xRKmVbzQ4WYRlsjFZAN8LsTvFmqqj6AqV5FMZ9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPL3k835ymZUGas4+XqlB55IkMnoo5AyIS/udxGMqh2ZjsWGHi
	6OAssLe50sG3CvLJq5Eb1BleuRjeNg1hPd/iCOj0MQywEZhsGst2/gT3+a0sp8fYkacy4iAWe0I
	bRHm2XvBUwB8x34tMAPV8GPntDfJ8BUA=
X-Gm-Gg: ATEYQzz41e56fUTcAy6Zm/2c7oXeVgi6MYBPq5+nCGpTujsQOZOE4JC0vCvpvN7ZoO9
	kB7HHr/4mp7fC5r9psGuFYOHpqxA2fk6T0pKDcV3PdDL4QfdGVqk6UkjgZ4aUTDqwgJM3EAXHSI
	jVc6cQZoinqwgxLVhtgJY1DKsT4RhuurF+WCeu6opSwj62+9v58wOCOCuhq0WIJnCU1adldURSZ
	i9jDO41sHFKNkPpf/UMuFvQOnSp4jiwLXUExFTojRvTwugYzO/5F/DxoI9ZCXn51lfUq7XR7dP1
	e5fTeA5eo3QMQQfoUp2cSFtMxf2bWehv62Cg04WjXS7Hd+JC2EwHIvOos2U=
X-Received: by 2002:a05:6000:4203:b0:439:b60a:b3fd with SMTP id
 ffacd0b85a97d-439da67c0admr856438f8f.37.1772768347131; Thu, 05 Mar 2026
 19:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304210212.235096-2-dev@der-flo.net> <c860945b84fb9b75ec9eb0299a4cab36c3afb69e9da90bab3d71c780e8cf18b4@mail.kernel.org>
In-Reply-To: <c860945b84fb9b75ec9eb0299a4cab36c3afb69e9da90bab3d71c780e8cf18b4@mail.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 04:38:31 +0100
X-Gm-Features: AaiRm50Y-ofn-920xfXhbyhfLc4qe-ICao7ynhomWVwWWLoFkhNM4kViredGKis
Message-ID: <CAP01T76=Am0SMkURBtcXKAm+uouMKR55ZbnzJC12heOwYuYs4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add LINK_DETACH support for perf link
To: bot+bpf-ci@kernel.org, ast@kernel.org
Cc: dev@der-flo.net, bpf@vger.kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 23:01, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3863,10 +3863,23 @@ struct bpf_perf_link {
> >  static void bpf_perf_link_release(struct bpf_link *link)
> >  {
> >       struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> > -     struct perf_event *event = perf_link->perf_file->private_data;
> > +     struct perf_event *event;
> > +     struct file *perf_file;
> > +
> > +     /* bpf_perf_link_detach() may have already released perf_file */
> > +     perf_file = xchg(&perf_link->perf_file, NULL);
> > +     if (!perf_file)
> > +             return;
> > +
> > +     event = perf_file->private_data;
> >       perf_event_free_bpf_prog(event);
> > -     fput(perf_link->perf_file);
> > +     fput(perf_file);
> > +}
>
> [ ... ]
>
> > @@ -4075,9 +4088,13 @@ static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
> >  {
> >       struct bpf_perf_link *perf_link;
> >       const struct perf_event *event;
> > +     struct file *perf_file;
> > +
> >       perf_link = container_of(link, struct bpf_perf_link, link);
> > -     event = perf_get_event(perf_link->perf_file);
> > +     perf_file = READ_ONCE(perf_link->perf_file);
> > +     if (!perf_file)
> > +             return 0;
> > +     event = perf_get_event(perf_file);
>
> Could bpf_perf_link_fill_link_info() race with bpf_perf_link_release()
> here?
>
> After READ_ONCE reads a non-NULL perf_file, no reference is taken on
> the file.  A concurrent BPF_LINK_DETACH on another CPU can call
> bpf_perf_link_release(), which does xchg() followed by fput().  If
> the perf event fd has already been closed by userspace, fput() drops
> the last reference.  Once the detaching thread returns to userspace,
> task_work runs __fput and frees the file struct.
>
> At that point perf_get_event() dereferences file->f_op on freed
> memory:
>
>   Thread A (BPF_OBJ_GET_INFO_BY_FD)      Thread B (BPF_LINK_DETACH)
>   --------------------------------       --------------------------
>   perf_file = READ_ONCE(...)  [non-NULL]
>                                          xchg(&..., NULL)
>                                          fput(perf_file)
>                                          return to userspace
>                                          task_work -> __fput -> free
>   perf_get_event(perf_file) -> UAF
>
> The xdp and cgroup link types handle this by serializing
> fill_link_info and release under a shared lock (rtnl_lock and
> cgroup_lock respectively):
>
> kernel/bpf/cgroup.c:bpf_cgroup_link_fill_link_info() {
>     cgroup_lock();
>     if (cg_link->cgroup)
>         cg_id = cgroup_id(cg_link->cgroup);
>     cgroup_unlock();
> }
>
> net/core/dev.c:bpf_xdp_link_fill_link_info() {
>     rtnl_lock();
>     if (xdp_link->dev)
>         ifindex = xdp_link->dev->ifindex;
>     rtnl_unlock();
> }
>
> The same issue applies to bpf_perf_link_show_fdinfo() below.
>
> > @@ -4143,9 +4160,13 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
> >  {
> >       struct bpf_perf_link *perf_link;
> >       const struct perf_event *event;
> > +     struct file *perf_file;
> > +
> >       perf_link = container_of(link, struct bpf_perf_link, link);
> > -     event = perf_get_event(perf_link->perf_file);
> > +     perf_file = READ_ONCE(perf_link->perf_file);
> > +     if (!perf_file)
> > +             return;
> > +     event = perf_get_event(perf_file);
>
> Same race as bpf_perf_link_fill_link_info() above -- a concurrent
> BPF_LINK_DETACH can free perf_file between the READ_ONCE and the
> perf_get_event() call.

AI is correct, but is not proposing a fix, so I will try to be helpful.
I think we can add per-link spin lock, so that operations on the same
link are serialized.
You can do the perf_file replacement in release under the lock, and
call the rest of the stuff (perf_event_free.., fput) outside the lock.
On the show_fdinfo and fill_link_info side, you will under the
protection of the spin lock, read the perf_file and take a reference
on it using get_file.
Then you can release the lock and use it for the callback and fput on
the way out.

Other cases are unaffected since they are already under lock
protection. I think a global lock is also an option, but I would lean
toward having a 4-byte spin lock in the bpf_link itself.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22690413273
