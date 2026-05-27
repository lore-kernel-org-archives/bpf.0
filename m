Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE637472D
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911693; cv=none; b=JE4CW5+7VPBTH5HTW0kzkvg7RJWhk0Ylh8CHgIyrEOo6V4Vhvb3IC2MDYHcW04uGTSqfINsMT5tRNjnoviAgAPgS7VvFhsgv3ucSNf8qsSNAGM4iXLQ4WioyPHwaEEmwvu8E6SlRaedemFCNOK59+wcPvgdmQFbv1NLKigA6ZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911693; c=relaxed/simple;
	bh=UydY+4H7spO6fhBmPwyXeOfz2ryeRKbVqjWjSB+kdLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KU7wBEahYeFopshOPGtU8nazDG2es0jgULcv4KxveNrlnui6S/uu4xSZEevQR1ibLaPQSPBa0P2V/ORjc5gl1GjpueQTkbsfQZOfWcX1NMC0ZdrHXRlE1KEPttipgA/+5fQUaKYScz/W1r2DE5ViLBCwEM0vgJl+xk1g5cpsgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di8IYSQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di8IYSQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAEE1F00A3D
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911692;
	bh=UydY+4H7spO6fhBmPwyXeOfz2ryeRKbVqjWjSB+kdLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Di8IYSQMc+R5x4VFnA7k458svnaW1znFlisJeoAmbqqLoBo5/hkS/FHwGQ9f2DB6B
	 cYieW1I/TapgFT0NcuKD3Ypw6NAJrC30dRKbv3hVPM4Nf1LptSKaun4Cv+JNF1Sijq
	 /Pvz6rx0ZszArWua3+BSykcyNCUPuIChP/7xURPAdGIzXa8mUFoEi/rHEm3Q3syr6F
	 jAkRHYwt4XV2ZsHvWorcGZa4t51d7Bj2VSw8Np8VLKOx20KVYel7mqJodLHNoh/JPS
	 qgA7U532zND6Riy+t+FifXSj2kfagkOiJJd6243fUSWeBQZQhLDc1IDnht6l9XxlV+
	 nzFOlxF+v8xag==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914db83362aso400637785a.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 12:54:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8NYWGSluj3wg6btP7UpVxBJeoT0TGo4EPiE4GdMwctsJ78lsM+pau0majwV8GWDAfiNpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKX7stNwRyseHDg72rlFVph7gnyVWos1bKAMe7EahXcRXXdsg
	Poj63HWpP3hGNWxCdJAXF5UHAPldALjqNadwG4tQIdySHshMoFUwuFRsD9Y8up347T1haaZeKrz
	zcJKobekqFTZm/LJK7BbCu/XWFDzUt6Y=
X-Received: by 2002:a05:620a:c4a:b0:8f2:1ccf:46d2 with SMTP id
 af79cd13be357-914a23e5d99mr3566882485a.32.1779911691486; Wed, 27 May 2026
 12:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527192632.2109419-1-tj@kernel.org>
In-Reply-To: <20260527192632.2109419-1-tj@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 27 May 2026 12:54:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7vOMp+T7jxWUABaicCBrqApH8sEDYG1HGgSBY=FFYJeg@mail.gmail.com>
X-Gm-Features: AVHnY4LFPs60fQRIoAWmY7ushCjwbYwdL6B3WcqeCMCqTMkHajj1UyyChsT7ElY
Message-ID: <CAPhsuW7vOMp+T7jxWUABaicCBrqApH8sEDYG1HGgSBY=FFYJeg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_arena_handle_page_fault()
 redefinition without CONFIG_BPF_SYSCALL
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 12:26=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On configs with CONFIG_BPF=3Dy but CONFIG_BPF_SYSCALL=3Dn (e.g. arm
> multi_v7_defconfig), kernel/bpf/core.c defines a __weak
> bpf_arena_handle_page_fault() while bpf_defs.h already supplies a static
> inline stub for it, causing a redefinition error. Build the __weak
> definition only under CONFIG_BPF_SYSCALL, matching the bpf_defs.h
> declaration and the CONFIG_BPF_SYSCALL-gated strong definition in arena.c=
.
>
> Fixes: dc11a4dba246 ("bpf: Recover arena kernel faults with scratch page"=
)
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Song Liu <song@kernel.org>
