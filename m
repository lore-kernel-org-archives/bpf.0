Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B602BE053
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281719; cv=none; b=NcymX7XWdbCYe1gngOOl4jF9E61XRRQe1lKX6LYRCXxsaUPJ/voYVn9NdrpDeParX68DLPooKSufXvb/00va6UOq7c3sNOdO2jnZnerj3GxKbvb08cPx2v2WHMaF0dJ2tly5sh06Z4PSJ1UJrKMPJMuvmSFs/cHow4ZUoym8D4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281719; c=relaxed/simple;
	bh=TO8T8T3MBEVRJNLT1pnFgzJROWTawlpJKSr43b0hRug=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0w8sBElm5EpssjGBbitpSVoLu74Kz/sztrkVNVtk+PWCWoZlRu1WRG37yUM/bkXv+zwR/w6+2h2vgQpPbdDAOOv5Wowm0u1IhUDjnVD6X5spdMyQlE4P8H7xyUOkR68XGhvF2QHMaIBxfXUGbWPaXzRt3uuDvd+ny5aIN0Tdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGvsTrmG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGvsTrmG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso7211445e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 00:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770281717; x=1770886517; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pPbYr9plY5gI40v9Y8GEacPTdPqDKVbthrrgz6453C0=;
        b=gGvsTrmGtDY9UO5BX4AjwTmge1dsJ45xX6R9H9HWZiuYXG1pXT2bnTXcea8a59eEzE
         c/1Vjc1tUti3oyAUiRL7LybbgmCrpWWcZt7lX7lep6ODHAu393ViRcM+wesDvMPopx42
         dxchQLRpM6GSh1Zynn7RC5FS4dmzue2g05itLhZ90FkpVOVfmTexSVniCWa2bL3AMNzu
         CKx8jOYXcBUe9LnJOlj4cC73vdFzuJ42nZsdzkzqbP8iCNHBTj2GhGyJogdnZ5BzMKTG
         YmmqFOGUnjkkUXoNTIx5K5YeXxQAhh8viMdj5lCW627rh2u31Lm4Ql0FCEAM0i4MV0Vp
         B1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770281717; x=1770886517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPbYr9plY5gI40v9Y8GEacPTdPqDKVbthrrgz6453C0=;
        b=RgX3/zbBIgpXX/O7IsYp/JDCjhB1MRaJawGsyy9fQJr+ZeVHVNojgvh5n+8+DO6B03
         HVUtRiTdhIPXBGLj77b2Vh66hKA1LUaEf3XjIHSasy5HHp8bJuKyfbLgHX4C81GNZp+Z
         Sdhf0A7pmHG2Cf7KeStbYFKQRuZKavnJcGPKPilW9o1fmWdn95ClEwgrndvfcLT7EzFq
         THMgkowJQjiw2W/gH+O8kETtlJySoiU80iz8sWA/AMDYwwk5tjvqVELJ+/cOAAHVJRCc
         OI8IC3gnr3Kb//oMIG4WA6d7jH8EK/LBY62FM0DRY/X9nA8q1rroeC9wwVkOuqtvLdqZ
         IO3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCJMESeoM0GdXY3IOSkghRIWGnLnuTF1u78JfS418POMV3nFOyendpdlZ7T0GvKTTFnUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzHzyes5g56sAx3z/iTRqmzvSks9Y1j80gpG9ewmR1aSlec65
	WHtDfFjGYtF5hPQTBEHTIe3WGYmQjopSVIIwfQ1rFm9q9FwSv7z8fqkv
X-Gm-Gg: AZuq6aL6sCPfrpuwF1qXdu603vVEFwJYz9H7BsMxlBizycgDETrpJydfeLYG+3cI7qE
	dXq3BeDJ43q8T9kfPhafeK8eKeTi6mmgInM/m1ldacgnzfwxlZj1WEuaIK1paLlj0uNiggARmyk
	EAo7mFDWFIa8c5so5JmxWmT3dKvSl8VAZuIZdLKj97GrKAq1UnFRZIQHXyYuVPSdpBNE+Rh37ge
	iLob7L62D3qJBX1OgqP+Ttip/yI65uz1A/YHKnfJsWsiBglWB8N/MFXO2Nd4ifP3iBHmJ0WnzcQ
	iAHlTcEcESgwBmkap8Kkrmsav62cjjOgitQwNF/XxrodxsD+7GaUEGxa43qVPkhDfPWXegjnJRD
	X1nUEcv9p704VeJ0i6zMidpdqZFLvGXBluZXyXOw2fyAoBc+haNvx4i2iuiU7
X-Received: by 2002:a05:600c:3e11:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-4830e93ee70mr79551375e9.15.1770281716961;
        Thu, 05 Feb 2026 00:55:16 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25d0dsm12749935f8f.7.2026.02.05.00.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:55:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Feb 2026 09:55:14 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 07/12] bpf: Add support to create tracing multi
 link
Message-ID: <aYRa8icSHFrfCyJ8@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-8-jolsa@kernel.org>
 <CAEf4BzYsE3W8QvtKBOZZWGudFjXJ-_szUZOejT-Ab5v72Sei+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYsE3W8QvtKBOZZWGudFjXJ-_szUZOejT-Ab5v72Sei+A@mail.gmail.com>

On Wed, Feb 04, 2026 at 11:05:09AM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 3, 2026 at 1:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new link to allow to attach program to multiple function
> > BTF IDs. The link is represented by struct bpf_tracing_multi_link.
> >
> > To configure the link, new fields are added to bpf_attr::link_create
> > to pass array of BTF IDs;
> >
> >   struct {
> >       __aligned_u64   btf_ids;        /* addresses to attach */
> >       __u32           btf_ids_cnt;    /* addresses count */
> 
> cookies suspiciously missing?

right, need to be added, no mystery there ;-)

we will just assign it to the bpf_tramp_node object for each trampoline/id

thanks,
jirka


> 
> >   } tracing_multi;
> >
> > Each BTF ID represents function (BTF_KIND_FUNC) that the link will
> > attach bpf program to.
> >
> > We use previously added bpf_trampoline_multi_attach/detach functions
> > to attach/detach the link.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/trace_events.h   |   6 ++
> >  include/uapi/linux/bpf.h       |   5 ++
> >  kernel/bpf/syscall.c           |   2 +
> >  kernel/trace/bpf_trace.c       | 105 +++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |   5 ++
> >  5 files changed, 123 insertions(+)
> >
> 
> [...]
