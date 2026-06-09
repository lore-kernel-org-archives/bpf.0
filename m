Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86D28C874
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011475; cv=none; b=lABRQcHiWki4CQFpPnwc17Gq3NqzI+FyvkCMQlGF52TGTWOBHVB8KLPooXo7opjQRwf+i6aGcDEzIpLlMnHEryNdOwI40N1gIxSa/ztzpBt6nb+BZQNVec54Hm031zLuR0QVr4Px8WTNv1lhfuw4rU1VvLoqg5dKFq8LEIijuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011475; c=relaxed/simple;
	bh=DBTUHWYYtAJHBUm6xFnBNoXeFgf5VXKZ/gLOxM1bD10=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3HUGOiDfHTkKYv9gWV+dguJENsv88X1iocF0PxDiPNJLOKBX7F4ZSVZGPCKhCZOQ1PxrTrxFyGsFlhBQEPyR22ohuWhFZIqIu9EkP6gra8TjliPlDSeAqemWPnC7HmXj8gfYNW6Z7t+ILMIpedWUGaXVf3JEa+ECpiJn5DKhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO5tu8mf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO5tu8mf"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45eedc94d37so2800369f8f.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781011470; x=1781616270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RtgZ2moWRCMeSXG0w3yTlyIp2nfaemvwN7OoUhkz6vU=;
        b=QO5tu8mfVZyLDCglPD8A8jyYAs5ERhnXw17RldOAAuVXvqeXkhbBF3b/HJJfYWEme0
         NlJ0+0P6J3Zg72AueKzdfU4Sj8u3FcjY3BHt2JeEfnwAMIBIER/N+Rb+rv8AWUMapKHc
         q+oPjZiG1gwJQLWyZe/K4HnxovSJQXbHYnr2dXvzfVwsTJgsT29mod3sm3/CRAbJuTb2
         84ag/OyiysrJ0j3QYrsJPPGJ1EmGXRjbjVxmbX2kkuoP4BzcB/3mapJxf3sqIYIDq7m4
         zyLgE2/0ooGbOup0y1Rn7vXj6oX83CudpqLQBBGEUBrAQacL8m4JHOX0wSms0GBIF0jh
         u9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011470; x=1781616270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtgZ2moWRCMeSXG0w3yTlyIp2nfaemvwN7OoUhkz6vU=;
        b=FPWbymUp12kBJiT6OlW7hIUO/FZXzCseiVWxeRcTZr23yDskUW0OCMoXmJbFFXcVM8
         0TCGau/5V2QjbTcHo5NTjOv2qEW4apP63JsgO1X7umkD/AYco0Pv244ESgKy3cHprock
         6nkF2pK6wkpJn5GSVMHRqQuI7mffjL1uzrZwFAtchdmucdVnFfv0btbk0h8BFLN9JBiO
         neSj2L1zBuIHC9RgUYOGV90jIbfk3goChVeedy97bRagU6JkZbCu5BLpQolpD+L8Vpgz
         8qX+LAL2IjHe1FnsnPWzvWSGITaUVkgVcO60bMXSF7zGca9ZCVOVLDrXA45kg9qj/XKJ
         pzxA==
X-Forwarded-Encrypted: i=1; AFNElJ/h6hm/kQyhzSI4FoXMLV2zhZ77UVTcOxv+P10s7XiJziIW28ew2MM5068As71umihC1QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2632cPz8vna6iDTXFsW8EDzxKjr2HBHiz7kJtdvi7dKkOkgf
	gL1/0XFr5LGDT8yqtqvscHLBlE22jlbCe+dFy8iJ00oSbVHUb8zyaiOi
X-Gm-Gg: Acq92OGl8nEVLV+4Qucl+3ve6tPQJXMh2qgWdRWreSduZ3k9GttX89qoEvxEepkRhFZ
	heF0rGFSC4cxOOaqQdnPBKBbmyRy5YKg3g9XmYHrWtJDizBjK77SqVzlhF+3+/3VvPzRAmsMTZb
	Due67OdKeNomBlOPvzd/nFCGcbbnAiHHvhjeTQKt+z3cRJAQanC12phsMQtH15rzCcDd2QnBVGx
	qC9GCUYUifwC2u/LubsRsUMeNdbt9cgkG+D5bZ5tFerPuwG9+JjSHN+cYq/osl0sJI4k8ncCmLi
	7tylTdV7gnx4qcLMVUe4Dn+d3p8mxm9G6AayVu/J3xvo1oJdyUHGp9UBFjWr8MX10Firham9cMD
	DOtTTTP6sa6DDhjJgagla/YAM1v9oJ97c6l9yQ2bO2RhjK9r/oA6ITuGzz3EuKZinXkjMfpVf/p
	QMxzH3uqqo5+cI500G8wIWeUnM4g==
X-Received: by 2002:a05:6000:4022:b0:44a:b931:f32a with SMTP id ffacd0b85a97d-460566beef3mr4044783f8f.27.1781011470193;
        Tue, 09 Jun 2026 06:24:30 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35133csm60043351f8f.25.2026.06.09.06.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:24:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 9 Jun 2026 15:24:27 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	songliubraving@fb.com, yhs@fb.com, oleg@redhat.com,
	mhiramat@kernel.org, martin.lau@kernel.org, yonghong.song@linux.dev,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 2/6] bpf: Add support to specify uprobe_multi
 target via file descriptor
Message-ID: <aigUC-Jh80ilRk25@krava>
References: <20260609104244.588321-3-jolsa@kernel.org>
 <e651c603d7b7501bbf77c4b516098c3135a8b45d445ed8e3994f6dd76d01f6a8@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e651c603d7b7501bbf77c4b516098c3135a8b45d445ed8e3994f6dd76d01f6a8@mail.kernel.org>

On Tue, Jun 09, 2026 at 11:17:11AM +0000, bot+bpf-ci@kernel.org wrote:
> > Allow uprobe_multi link to identify the target binary by an already
> > opened file descriptor.
> >
> > Adding new BPF_F_UPROBE_MULTI_PATH_FD flag and the path_fd field for
> > the attr.link_create.uprobe_multi struct.
> >
> > When the flag is set, we resolve the target from path_fd, without the
> > flag, we keep the existing string path behavior.
> >
> > I don't see a use case for supporting O_PATH file descriptors, because
> > we need need to read the binary first to get probes offsets, so I'm
> > using the CLASS(fd, f), which fails for O_PATH fds.
> >
> > Assisted-by: Codex:GPT-5.4
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> This change also fixes a latent bug in bpf_link_show_fdinfo(), changing
> the exact-equality test to a bitwise test:
> 
> 	else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
> 		seq_printf(m, "link_type:\t%s\n", link->flags & BPF_F_UPROBE_MULTI_RETURN ?
> 			   "uretprobe_multi" : "uprobe_multi");
> 
> The original "link->flags == BPF_F_UPROBE_MULTI_RETURN" was harmless
> while BPF_F_UPROBE_MULTI_RETURN was the only defined uprobe_multi flag.
> This commit adds a second flag (BPF_F_UPROBE_MULTI_PATH_FD), so the
> exact "==" comparison would misreport a uretprobe_multi link as
> "uprobe_multi" whenever both flags are set.
> 
> Should this carry a Fixes: tag pointing at the commit that introduced
> the fragile comparison?
> 
>   Fixes: 803f0700a3bb ("bpf: Show precise link_type for {uprobe,kprobe}_multi fdinfo")

hum, I don't think so, it wasn't really a bug until this change

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27201419867

