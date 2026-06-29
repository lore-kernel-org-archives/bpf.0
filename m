Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB83A4513
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766283; cv=none; b=OQMaC5NSQcfsXgavhLPWKcEjF5/VTttcHL3XYuxokUAwnlQDMiGq3FjwqQlWEuvr5At/INLbEbzDsyjibu4n5wqE0BDdrGsUQ1y5/AP6OTF1vJIrQ98WLrDs072ItqxEVWFOZ3VseGThZJhDINT+LfuqYsGQCB1n3nKvrVKd7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766283; c=relaxed/simple;
	bh=rmX0NGlLAo9ekZH6Y2jezlm9CoKFQQVwnfBmxm9MLjE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA4joBmMdi77YjeSPxXtfcLg7oLcSTXP5BkMoguD94+jaPtmwnPVoRWqhli69V5Q1hSUQd922HNJkx4Gs0Oc7pxNs6MyawDYmh9G+7VpXaBSJPg6vs0Hg/f280hRZjYIZ43gpS48tGKRqYIvdvn9DbqysVDHf5K+d4hBrfR5rIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idsrUZbv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idsrUZbv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-473dc4cf238so876646f8f.3
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782766279; x=1783371079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYyY6lEtB4HL1DdfAYLDKmmLVQmR71vYlmUmwFPjYVE=;
        b=idsrUZbvuOqKoR1VOWcBB57kBa2TuJMmyatDczEYUjni3PVWUe5CxrEmJdrQ4YX7BX
         fFrMD5VmpF3CYN5sE1BoPFAFCupC9sJedHi19juo47kE3hSgyXJY4IFKcJS/tzvpC+bb
         KouaeyBWSMUYWNoM2Bp3XfBvDimkcCowDrACAAhyIal9eK6S0kplvNciuTJ9YcWf1hiG
         b4tW1mD5PsYIFxfY95iGVNenZIp/TnhcZHMsjUxUJDlkTItglioUkAj435u06hrn7ePO
         T3NwUE8jflsnWtRktab7o4x4EN9JosHgn7udkrKoVcWs4hqQ439LvJP+e8IcZaZ+2tix
         9Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782766279; x=1783371079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYyY6lEtB4HL1DdfAYLDKmmLVQmR71vYlmUmwFPjYVE=;
        b=JIPJGmqtPi58Jc+SidFKDl207WuxXEe/a/K63NIY8ZzwldYcn5a1t+dm49TZMUctEM
         LP5cQsx8WtuYL0VO0ZeZaTwbsVo9sadaXK6VHDmUB3RIWQlAIXvi7NA/f6msaTngCr+I
         qztPI4VbAAkfjega444VgcasfZJseTkvog2nh6RoaTy1b/pgUBIAgokZpUwGlRBNaQIi
         puPhOjV4LvMETrF+rdlxcRCIBhwpkTiiKs7FKH/3+mN2+VNA1htPL6Lt2B4VdOvbmjFD
         c55rwk609KFFeY4aK0cpU+W5JUCoOgtcSiSMeGh/fLr5sYkH3YLUnd3zI+VaPMlf00R/
         Vovg==
X-Forwarded-Encrypted: i=1; AHgh+RpKBRfoSnUpralBP8+pifmtA6b6zAIzQb6F0EnCLQdMp6aArygd7JMNjEFsus1neEcuUGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgGll/ZBesJc5djIrHfXhIgSLjhCUXAi6uIiluv8sTu+XC+y/N
	HTp2MNQbiDM17e36gsp2w/P1eUPp0nuV8UkkdkhYzfcPa0F/qaef8xEn
X-Gm-Gg: AfdE7cnmucomzR2pEWnn8OsfO9ohQBRZeHlZBgAGwZZkZdSUtzFGRhCzs754xLJ89L8
	MdmW4lNzS5RhLGUtP45Iylmzvq28Ge1EFSXsA613ekYKMJqIVkytd3l8u8EiDpuZa+3LkwgOl4f
	J5TI5hC87uuhHc82NMX30H1aGKu4WYB3lxN9lFbGll5qdnWLH2aafnxcS1+C1gshrCqPhp/WPzN
	GjMbNrLIQPxhFRiy01qrS8a986ki29LTwZjBKgnwuJ1bBD3h0dpYy2bu4Jjp8Etflr3Ahw24QU2
	PckEIj8MrobcUMOtqGfRviDTds1DE0voiapKMenAEgdnzf88O3s00iyoYdXw3gwGwd+O0HHCq9f
	oz/Iw7ZySgkhUTX9sWdREBpvryPNpEHbbW/AyeIyXNCMMJdlH6/1Vof7I0MCNX6D6itviceP2J5
	bDt1mMcYnv+olcHO26L0Plmg4CnLC5+FpG8Sw=
X-Received: by 2002:a05:6000:2c0b:b0:473:ba02:8cbc with SMTP id ffacd0b85a97d-4754d7e38a6mr1092712f8f.0.1782766278470;
        Mon, 29 Jun 2026 13:51:18 -0700 (PDT)
Received: from krava (37-188-219-218.red.o2.cz. [37.188.219.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47566c0deacsm938666f8f.26.2026.06.29.13.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:51:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 Jun 2026 22:51:12 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	songliubraving@fb.com, yhs@fb.com, qmo@kernel.org,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 3/3] bpftool: Add tracing_multi link info
 output
Message-ID: <akLawCtmY4PkWDAO@krava>
References: <20260629143844.862369-4-jolsa@kernel.org>
 <3205a51da759dfd735af18490c48f952b34dd066a1ff0d47f832b0a1a5de6469@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3205a51da759dfd735af18490c48f952b34dd066a1ff0d47f832b0a1a5de6469@mail.kernel.org>

On Mon, Jun 29, 2026 at 04:05:27PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index bdcd717b0348..eb0ba9d71692 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -377,6 +377,25 @@ static __u64 *u64_to_arr(__u64 val)
> >  	return (__u64 *) u64_to_ptr(val);
> >  }
> >
> > +static __u32 *u64_to_u32_arr(__u64 val)
> > +{
> > +	return (__u32 *)u64_to_ptr(val);
> > +}
> > +
> > +static struct kernel_sym *find_kernel_sym_by_addr(__u64 addr, bool is_ibt_enabled)
> > +{
> > +	struct kernel_sym *sym;
> > +
> > +	if (!addr)
> > +		return NULL;
> > +
> > +	sym = kernel_syms_search(&dd, addr);
> > +	if (!sym && is_ibt_enabled && addr >= 4)
> > +		sym = kernel_syms_search(&dd, addr - 4);
> 
> When is_ibt_enabled is set, can addr ever be resolved by the first
> kernel_syms_search(&dd, addr) call, or does a match always require the
> addr - 4 adjustment?
> 
> If a match is only ever possible at addr - 4, would an if/else be clearer
> here than trying addr first and then falling back to addr - 4?

I see trace-able functions without endbr instruction at the entry
on kernel with IBT enabled, like:

	# cat available_filter_functions_addrs | grep get_next_root
	ffffffff81211a70 get_next_root
	# cat /proc/kallsyms | grep get_next_root
	ffffffff81211a70 t get_next_root

and having adjusted functions with endbr instruction as well:

	# cat available_filter_functions_addrs | grep ksys_read
	ffffffff816f6404 ksys_readahead
	ffffffff8182bf14 ksys_read
	# cat /proc/kallsyms | grep ksys_read
	ffffffff816f6400 T ksys_readahead
	ffffffff8182bf10 T ksys_read

so we need the check as is

jirka
