Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0984381AE3
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165988; cv=none; b=fra7Z4Pj4r9tlk8Cbi8Mhjdej3oO08vwvXoS71aaiNrsqiYHS0qlYSNSpMY3/1OVZxbn1NQUPpjiMaq1mvl83HsQ7XU1IS2HL4NA41xI0zashvLB7+HHADyGX28lM20o4/W14E3qwxNE6TIrNDexmMgYTBzfZp6mqABrpMahFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165988; c=relaxed/simple;
	bh=zymSMMvCR2JjltafzmkyKkmW2fk8OvH6x5jYbhMgJ74=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=hAQ83qhRqQmcxnps72ReGlwJxSCe9kC6tewlo4M85Akeb78nJIM1SbDzXFoGBeVci0Snc4VG2GOsIdGvUJDe7+/oaQbUSB52irVpA8M+dk+WqOgp/CVrPWlsWAbC+M2LYrJ193Ok6KhleJeTKNCVANorNSTo6qeQVrYFjtDQle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzhOym6s; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzhOym6s"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b06c0794cfso907577b3.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792165986; x=1792770786; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rkhVCAhuJM7IeaHhiTrkOAj+zfL4bf3/t+T0c6zPLks=;
        b=XzhOym6sk2tlDCLGLXbViooKE2A1lyJXWag0obag0dKq+TVmOQc563uS4fKVKRDqvA
         dl12u558QlF5umMderJVg+jWLVjTrj0crLa1aaEbffbDiCK/rgpaDtI8muGQinnMFYhY
         Ia0+HY3GnCThWyMXDySn63rmCYn28HEyWAng2vKD4HT3QL5E3dAKq7zhfgKXkH8p/tHf
         Y9Kay6soDA8h6m0xxNXtU0IBE/wf1NX0FA3Lu1790smfyUHNm6hJE/Cx00OREU6CPTbp
         ZhBgt4/gdr3LmIBF4DD/EziYRGwJ+46fYo11GiWzMf4LeEA/KXat79AN9dN5IJi6TCGn
         +kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792165986; x=1792770786;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rkhVCAhuJM7IeaHhiTrkOAj+zfL4bf3/t+T0c6zPLks=;
        b=PUwa2KVBrTsoSPhcs6sFXsxr7sLVGbJ25Uz1y/3PCqfgLCAi25CN7Z4BOJAeyxZFkn
         QbsVpzBBE5BH54EYXI/qDqmppFBDMYAkmksyFP0ZVAVIc1C/8/0RLofjCZfubLHn5QiV
         VSYnB4fcbbr6wsFjqZkWf2NMTJVw511Ajt51RiWk9LZypkH9ucwlJMslfoZPPwebumxj
         gZ4ZpBMxN3wvMaQxbqHA+JGZ9Dzapta40fXNIHfNyAFnmTLveuNQeB/4doohRJhivOB3
         0ER4CuRE6iVwWsUbWxCDecVgzlNvatIaZQNpVJPBGx/EDJNx7HW54M1XYtUtgBxVHVoO
         1Z6A==
X-Gm-Message-State: AFq9FYIt8PaYs/7EZZmr8vnnnFayegw6uemlNe5IWiQHCRh2nIu3/m9C
	/yTGEDncy2Dy69AQ+yfb1Ri1TnQrNZmsQzkNMuIPb/Pko1ZAlodAcLnS
X-Gm-Gg: AYBFou3ozfMfnH+nKjgVAtUb+Ggqnl/HUTjO2wMJT/Q08mA6xj5hlIU0gD55eEPSyNi
	ugYyAZ6JPpJkz2D2ApJB0abqgQnv71fIU9As6euONv2w4QXggZ7t4qCnE5vixZFhy5mKNJantKW
	8k0BACUfaucJ+AqSCoImxC8p0jGusK9KAiKfSDYQE40lcUNxwyko1Z8oi5zFWajzd7bHA+nehBS
	3QHMRYXyibIoMeqzO5JWusfvuXDjslrslhbJjwE3w2cYEzKL5I6DImPrKzXX/TtT/UQuQmJ2fle
	gqwzjxDNE7zSLCf2VDfXVFVEenZItjPpsKa2ANDq7n++aTQDNcrsbpy1oGAFvXRzBrXSQkwb65h
	/Sb2o/B1zMyjuv+AChKsZpJkaOiIGJxzGIZShFZ/L4ql+yZEGGXKvB3GQXPudFIIGrhGegqOG2s
	pUbF/hf6s3b42h4ht0YLHWPkou7ua5E4MmIfFDumDk/xgYJ9tf6PzPQRD4tb4+xTMsmQCsdgrcz
	IylbATOUGB9qM+KbSWQNuyPuUR8VbufWZ1tYZRO/EZwL10WFnDMcvt6STaZR55loQoBwopKpPt1
	SjU=
X-Received: by 2002:a05:690c:680a:b0:8b0:b12d:6c55 with SMTP id 00721157ae682-8b0f21bf761mr1547087b3.51.1792165985723;
        Fri, 16 Oct 2026 08:53:05 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e58892cfsm11098897b3.10.2026.10.16.08.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 08:53:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 15:53:03 +0000
Message-Id: <DM6DTIR83Q2M.1GEPF95MFWXY5@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Quentin Monnet" <qmo@kernel.org>
Cc: <bpf@vger.kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 "Cupertino Miranda" <cupertino.miranda@oracle.com>, "David Faust"
 <david.faust@oracle.com>, "Ian Rogers" <irogers@google.com>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, "Vineet Gupta"
 <vineet.gupta@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v1 5/8] bpftool: Emit __bpf_core_pso on
 verifier-rewritten context types
In-Reply-To: <b0bb3596-35a9-471b-a666-d7a638d00e5d@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev> <20261016000012.2232059-6-ihor.solodrai@linux.dev> <DM5VEJ802JZJ.2Y2NI0GZNVXMD@gmail.com> <b0bb3596-35a9-471b-a666-d7a638d00e5d@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 15, 2026 at 10:49 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> When PSO lands, people might run into this as soon as they use new
> bpftool to generate vmlinux.h, and the failure is very loud.

fwiw calico does
  if (bpf_core_field_exists(skb->gso_size)) {
on __sk_buff in skb_is_gso().
It includes linux/bpf.h and not vmlinux.h, so it's not affected,
but the pattern is out there.

> Yeah, the __bpf_core_<foo> might not be the best name.
> I like btf_relocatable for PAI, should this be btf_unrelocatable?..

A struct without any attribute is not relocatable either.
iirc Eduard used __bpf_ctx earlier.
It's more of 'hey compiler dont mess with field offset'.
'bpf_static_offset'? 'bpf_fixed_offset' ?
