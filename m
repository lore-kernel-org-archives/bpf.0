Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA461346E43
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293813; cv=none; b=M9YyICzSbXVN2Ya0qJtlyJYyh9fuwX5nTLgLYh9uRcSKF3InJrKEtOY0v5PCxGPqK8aYkWs/hmAdD6jVRctudxSnyoM6anLpmr3vKcnR5L5KqCsWtlGrU+oFQw5B/Z4gNS0dyxK7grT1htp+UFSY33tFk1fzye0/0j5cHUe/tH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293813; c=relaxed/simple;
	bh=H7MvCwSwiGAOyf7wrR2Uxn2Q+p2d/30Iiv4HI9AUo5c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb5/I4iCSXm4oTIct63+MWU02zexDg9JrjekWnkhRVBWYjTnhVrROIwmtGvZKZJfo2xmfem1HMh5t4KvSobu99tePHIdXZ9L8AepjLeRphAcKhohyK9xOjCABtHjJJYBnP7qFTVIUQ5Y6wUSAZxtUkZZ1WIAf8ypgPHufOm3nbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sl8LvnxZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl8LvnxZ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4923139e940so5108255e9.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 02:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782293804; x=1782898604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1wJNxSD3/+hWC52NiyTfSDgbYf4w4rvYHBQaUdLdSz8=;
        b=Sl8LvnxZhcO5eQfwc6sUFKfGwoZERyjEc3Skog8mDZaI1F3a+kFjcx2ANW2uqpjtiT
         j2T8rTdRL4/L8+Y1xrlp+cnk5mAvxWCffxKW8l9Y7XyaMlmNCnQhdxt7s30Twq3UdKJ8
         3jlwQ4gfievddZuyvY9su59DCi/MDMmJ4Tf8gpSp9YbYT4RLuldagdtmg/MrwEP8REIV
         LkzhD8uHpryIpMCyvSLmZBHRf6EshdBbOoTN+fgo5mG9wybjUDQzeKIwmTIW1AQYfXYm
         ZsI1QNa1p4My73hqaEs3X8t5VssTtY758agZ+M30NUZmiJ3y0bSCCaOw8XF/6YC0SAK0
         jhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293804; x=1782898604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wJNxSD3/+hWC52NiyTfSDgbYf4w4rvYHBQaUdLdSz8=;
        b=Sy+/G3QRGiuZb3E4rrn/LENTQSZbPnJHu+tWy+xg4nTtOI9uX7Tdh6KSy51vI9hJJV
         7N+Xv2peL2bxd9921pHbgaNJsh5hjQJslkDNj/VA9TFEp6Wlcx+2IjZtuLvvE9AaiSfI
         qAbcxKgrjhX783Ua9e4Xy0QNCWI9Fr8YzyKgelNCBlQgZ0+8UDDbssO/IeYym0U8zfyX
         txoA1J5tfL6Gq91XyPPHihSvqTQ+hHHn0NpWaC1rbylHT+f4HmyGVzrcpGc9wX6qwGDt
         te7zkGlgfUk2LJvbw/iHf796qAnLavQK2hlE3XjM/QgpLFIm/HdXmvSBX+GM6xNmb6JC
         ZDmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CWIEGR3jUYZWyibYW/f8VVu5RCz1dLZnAT4LJx0s3A2KNxyLWgpnacWkx2zXixuc0rbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1cMuSUpS/y/nUwrdNB3DahyoNUG880BEWCTNwems+53+JDM+I
	Hqo7V1ezD/V61VQAlh/wNBEIAdce3BVuARzAbkwJ3CSElDcLCt8CZ8WW
X-Gm-Gg: AfdE7ckGfmKlzenD/Oy856PTzpxALxHvwORRReIpEy1cMupa0upILoOCQmiUJfoDctr
	Ur7jF2yk0YE5uPlkLzObwLxxqAmrBRDrXzHA+KwFIG8/xeo6YIIkJFmc7WNmOVWrGBfME2Y5CPU
	95EtqzYN8Mp5zqu9q0klz1UfHseHdpg5BOlIlbGnuGMK9e91nc6ZXnRL2zxlOPFWVvKzjbn6aDL
	OVBMDMR2muXlCSaP6Dy1TzOmpqhhFLWyeVHxUK6bIMqJertt49uiARsmWBIlCF/ZQRLmhjCeTrX
	8SI8dnhpWT965eK46YuDCMhCkvJOP0yFfohUjf4cbxcM8AZNUGyfkCFfIECDG5rW10UBn0WVWgV
	hQBjgqrna6boMTH8xVxg8K6NWceGNq/s5ed7jEF0Wme65gItj+yDrH8k/E8c8gUsN3MFBID7NEe
	hstUcyQv6hSX0=
X-Received: by 2002:a05:600c:6207:b0:492:523f:a3df with SMTP id 5b1f17b1804b1-4925b34a37fmr101182075e9.5.1782293804006;
        Wed, 24 Jun 2026 02:36:44 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd30078sm440991485e9.7.2026.06.24.02.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:36:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Jun 2026 11:36:42 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/3] bpf: Add tracing_multi link info support
Message-ID: <ajulKn0pB-Nh19yx@krava>
References: <20260623142417.275892-1-jolsa@kernel.org>
 <20260623142417.275892-2-jolsa@kernel.org>
 <CAEf4BzYVjf4PfJUedkzRUteNOsb7kHafAbndaaNHBbVHqtOEPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYVjf4PfJUedkzRUteNOsb7kHafAbndaaNHBbVHqtOEPw@mail.gmail.com>

On Tue, Jun 23, 2026 at 02:01:08PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 23, 2026 at 7:24 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding BPF_OBJ_GET_INFO_BY_FD support for tracing_multi links.
> >
> > We expose following tracing_multi link data:
> > - attach_type of the program
> > - number of ids
> > - array of BTF ids
> > - array of its related kernel addresses
> > - array of cookies
> >
> > The change follows the kprobe_multi and uprobe_multi link-info convention
> > of optional output arrays with an in/out count,
> >
> > On top of standard tracing link data we also expose addresses, because they
> > are useful info for user (especially when the attachment was done via pattern).
> > This data is hidden when kallsyms does not allow exposing kernel pointer values.
> >
> > Assisted-by: Codex:GPT-5
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       |  9 ++++++
> >  kernel/trace/bpf_trace.c       | 55 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  9 ++++++
> >  3 files changed, 73 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 89b36de5fdbb..80423ccc6b57 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6839,6 +6839,15 @@ struct bpf_link_info {
> >                         __u32 flags;
> >                         __u32 pid;
> >                 } uprobe_multi;
> > +               struct {
> > +                       __u32 attach_type;
> > +                       __u32 count; /* in/out: tracing_multi target count */
> > +                       __u32 obj_id;
> 
> we have attach_btf_obj_id in bpf_prog_info, but target_obj_id in
> bpf_link_info for tracing programs. The latter, though, is actually
> not always BTF object ID (it can be prog_id for PROG_EXT)...
> 
> So, me personally, I was confused what "obj_id" here mean, it would be
> more obvious if it was called "btf_obj_id", tbh. But that's a minor
> nit/confusion, not feeling strongly.

ok, btf_obj_id si better choice, will change

> 
> everything else LGTM
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

thanks,
jirka
