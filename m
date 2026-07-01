Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647E47F2C4
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905475; cv=none; b=s0GZGbdgTewZ81Wdu+Ff+A9if0mM8dJSqf3I0fnFHHaHfWVJsRrpArW5Zd1q5OzMo/H0N0KAwGrGHz1SNvgDDHysOvHehmB7Ip+PHHdaX5UhBF563jGDEUhiuNB0ctrCBgGXADWN8wi9lHcS5zx5C53e9PsZbI+x9yiKw6VbitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905475; c=relaxed/simple;
	bh=DhSFmLeEgdGWi+ae04/gRPAnaho/FIceghLEfYJsDT0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAWLayt6qq/wamPcc/6jWoPaQpQZ+hrZVkPp7mYSlCXIWjgLi0zqurAhhVS7jNHsdjS23IYmq3npxasipER1PQSz6+3SYbHzAG20u97g+ThwF/MK/NFjndFHl8Fm2OfvdyKoFoR0UfWxe5QrQfasTuGRCy9z0C5xAX5UnIKz9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgiPTkmq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgiPTkmq"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47122683cf3so401660f8f.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 04:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782905472; x=1783510272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vShrZYDj30pK3AOFiKf2PUVnjLWAcQPFaE6HtzGHisg=;
        b=UgiPTkmq+4KsDlx6TLoiycYFuDwZqAFqqktN+omrIXtS1BFzL1ZkpaYEH6RMUkBR54
         00P8QCOU21W/kp7F2gbPX1TwNHuXTBHKqzJk0rY8yJkqVPJj3HOVtHpxGsiXGke24d+x
         cJvF7b8T+IZRU/1ZGtgUR7zXDWyk4GDmlQTR5KS80eMBSCu9Kw34lezPxVWzZbesQETr
         qRbltMaVFY5Rp1MS16EEYGfFXdeboCIcJWag08EHuaf7NlYjXTKz9bTRu+Ljsuy8R746
         2UcoZKJx4FuNM516MpCxC+DBH7DkmvNAdJAGgPFiXEhdSkFHDVycbWuEnnEYQdc10seX
         mfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782905472; x=1783510272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vShrZYDj30pK3AOFiKf2PUVnjLWAcQPFaE6HtzGHisg=;
        b=mflLx7IIGSBi3t5+jN3ux3HG68hCEfrT9p2/cbnJn5s0yQXb4kqSlOYXASo9YJl3yX
         Dpoh9Qa6W4aB2twpatnfz2zIG9Dmn3r2kTsRLGQ7IOGzXGe56G6ijaGUAlURnaYTOsJX
         sEJRk0EFWHj58KrSb9HhfeOxqXvE6qcEjxfcu2052dVAmkZAcK0pr+afLpG45Ta9lNaD
         k02DwHGZkmgOq724P7IyVnxSXIAmhBoUpA//MvUiKjWC5fECW7dQxQXka/Tpnd/PDwD9
         CdXqvZ99b9RQcLUAEFBG06tCCFbm3IcufjziJlGb8BMSg/uFg5+1RBdtFvDMbu0UIWax
         CwHA==
X-Gm-Message-State: AOJu0Yx8iVo6xi9p24Z1PMyGAMNtcGS2muVCyYlMl/HmO8X74O0/6EGA
	VFq4w8ogDfMBrrNRVdjkks/NINZHguD4d5pua4UO5/BVcZ6RGfbqmflWwRERJg==
X-Gm-Gg: AfdE7cmWis7CN2H6vAnoo/lJBVfMz+pfI+9nD04cK/kgKcoMFVltLYmbluzg6Z2YAjd
	EIUGYP1VxMnHU1BvK4vEgvyfD/X3W5SLS0VV31UZV9MbXUtTr1jv0kVDwqdk+xST6+ScRqZACPN
	i00tNLDa4198VAnQVHz8473JBbmXutrFGCpcoASfsqU+k+t7xCc9Hwq2erOpHmiUSxb+UCpSSk7
	lKjrsP5gbcr0ZEWMZLkr93984jIBR19DP54rS3ucUw92xbYquJ4GuGYchSQXrK3RHjoLRzmmd3S
	wKmiI0IKspG0m9Riemza9c2dz7Kcd5HKgsMuRqPQ38qkBh2RFNkeDXYQop4q3LKFtV1SK0ILwgi
	u7Iz5ot/ngg71PQWOso+nZDoipLnrYQNQRG7+LOEftb/lu1D2FLpCAAtZSGc7LLi0ezOA99EMiC
	DYmnWMX/Ndrq1Yup+E6/Ck4hnm4azHwNpHpMk=
X-Received: by 2002:a05:6000:2311:b0:460:3233:beed with SMTP id ffacd0b85a97d-4775a6d1f9fmr1984131f8f.41.1782905472203;
        Wed, 01 Jul 2026 04:31:12 -0700 (PDT)
Received: from krava (37-188-177-177.red.o2.cz. [37.188.177.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195a7sm16164248f8f.7.2026.07.01.04.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:31:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Jul 2026 13:31:08 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv4 bpf-next 3/3] bpftool: Add tracing_multi link info
 output
Message-ID: <akT6fHCSdJGFXmcK@krava>
References: <20260629212208.895962-1-jolsa@kernel.org>
 <20260629212208.895962-4-jolsa@kernel.org>
 <20260629213330.0ACD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629213330.0ACD41F000E9@smtp.kernel.org>

On Mon, Jun 29, 2026 at 09:33:29PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] bpftool uses a non-existent `tracing_multi` union member in `struct bpf_link_info`.
> - [Medium] The kernel-side `bpf_tracing_multi_link_lops` is missing the `.fill_link_info` callback.
> - [Low] Memory allocated for `ids`, `addrs`, and `cookies` is leaked on the error path of the `bpf_link_get_info_by_fd` syscall.
> --
> 
> commit 3c4bad76286f49adf87a7b01dc7042ac6368c5ce
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpftool: Add tracing_multi link info output
> 
> Adding bpftool support to show tracing_multi link details. The new output will
> display attach types, counts, BTF IDs, addresses, cookies, and functions.
> 
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index bdcd717b0348f..088d1d206065f 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> 
> [ ... ]
> 
> > @@ -403,6 +422,52 @@ show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> >  	jsonw_end_array(json_wtr);
> >  }
> >  
> > +static void
> > +show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> > +{
> > +	bool is_ibt_enabled = is_x86_ibt_enabled(), show_symbol;
> > +	__u64 *addrs, *cookies;
> > +	__u32 i, *ids;
> > +
> > +	if (!dd.sym_count)
> > +		kernel_syms_load(&dd);
> > +	show_symbol = !!dd.sym_count;
> > +
> > +	show_link_attach_type_json(info->tracing_multi.attach_type, wtr);
> 
> [Severity: Medium]
> Does `struct bpf_link_info` in `include/uapi/linux/bpf.h` include a
> `tracing_multi` member?
> 
> It looks like the `tracing_multi` struct is missing from `struct bpf_link_info`
> in the UAPI, which causes a compile error here when trying to access
> `info->tracing_multi.attach_type`.
> 
> Additionally, the kernel-side implementation in `kernel/trace/bpf_trace.c`
> appears to be missing the `.fill_link_info` callback in
> `bpf_tracing_multi_link_lops`.
> 
> Without it, will the kernel silently return unpopulated link details when
> queried via `bpf_obj_get_info_by_fd()`?
> 
> [ ... ]
> 
> > @@ -1114,6 +1226,26 @@ static int do_show_link(int fd)
> >  			goto again;
> >  		}
> >  	}
> > +	if (info.type == BPF_LINK_TYPE_TRACING_MULTI && !info.tracing_multi.ids) {
> > +		count = info.tracing_multi.count;
> > +		if (count) {
> > +			ids = calloc(count, sizeof(__u32));
> > +			addrs = calloc(count, sizeof(__u64));
> > +			cookies = calloc(count, sizeof(__u64));
> > +			if (!ids || !addrs || !cookies) {
> > +				p_err("mem alloc failed");
> > +				close(fd);
> > +				free(cookies);
> > +				free(addrs);
> > +				free(ids);
> > +				return -ENOMEM;
> > +			}
> > +			info.tracing_multi.ids = ptr_to_u64(ids);
> > +			info.tracing_multi.addrs = ptr_to_u64(addrs);
> > +			info.tracing_multi.cookies = ptr_to_u64(cookies);
> > +			goto again;
> 
> [Severity: Low]
> Do we leak the memory allocated for `ids`, `addrs`, and `cookies` if the
> subsequent `bpf_link_get_info_by_fd()` syscall fails?
> 
> When jumping to `again:`, if `bpf_link_get_info_by_fd()` returns an error, the
> function returns early without freeing these arrays:
> 
> tools/bpf/bpftool/link.c:do_show_link() {
>     ...
>     again:
> 	err = bpf_link_get_info_by_fd(fd, &info, &len);
> 	if (err) {
> 		p_err("can't get link info: %s",
> 		      strerror(errno));
> 		close(fd);
> 		return err;
> 	}
>     ...
> }
> 
> Should the error path free these arrays before returning?

right, that's pre-existing issue, I think we could do something like
below.. will send a separate fix

jirka


---
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 088d1d206065..3f5b3b12a404 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -1156,8 +1156,7 @@ static int do_show_link(int fd)
 	if (err) {
 		p_err("can't get link info: %s",
 		      strerror(errno));
-		close(fd);
-		return err;
+		goto out;
 	}
 	if (info.type == BPF_LINK_TYPE_RAW_TRACEPOINT &&
 	    !info.raw_tracepoint.tp_name) {
@@ -1281,13 +1280,14 @@ static int do_show_link(int fd)
 	else
 		show_link_close_plain(fd, &info);
 
+out:
 	free(ref_ctr_offsets);
 	free(cookies);
 	free(offsets);
 	free(addrs);
 	free(ids);
 	close(fd);
-	return 0;
+	return err;
 }
 
 static int do_show(int argc, char **argv)
