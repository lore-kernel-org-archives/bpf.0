Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E72517A5
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233175; cv=none; b=HzgNWleOM+b+x4fmd+2vu3EYlXwTeMywzMPZUafnvt2Bj7mHu/totUrSM95DN7j2C4VjNXX1whqYnraPWxFNkZ5XyeMQyabhr3FfYH5v+sKTUKB9/5z4zpoXOYfn4PUJ8RyDG6QqzexFuN1zy7ym3y7LcyLmm8JBzzRoedMrlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233175; c=relaxed/simple;
	bh=NeRUS0mlQ0BUx8C1CFgVHQPP6mbHEHN9+svmX2tF2a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZ4a1rF0UL8xbxJOSoyv3UgbINPyA2ETXAhLXBU+EDinq5vRtEogeDH9U7AgaUe2kX2c7Z/4kzz/s/YjLykw9UqFpLWhPib07n3P/7xJgIdjq9vL5RK8g9HK6MKbeivjAMS6MTP97mpX/CcJ/deI7QpfeuQCm/PCCIWo0j4E/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgWzpwbX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgWzpwbX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1777C2BCB1
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775233174;
	bh=NeRUS0mlQ0BUx8C1CFgVHQPP6mbHEHN9+svmX2tF2a8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NgWzpwbXVo3gHHtBhZtvB/giV+wgErSExYLHmUgdGMoYXu3+efDJNaA60/LXjy6Wb
	 ozkUImOO/qihjzV2nW7bPPOXHY9WCafTOjC3Tx6aQtptCLMTkZ5NxDXEJASEhAsA9w
	 +/PcKviDIgzQgkB3jbHGObh9uhOEgFFK0uhViA4H4CmkL6VJTGwLdMxHAZPeoXGgM7
	 Um3WFSbibo6NS8ja75z6xeNSPPNk8b3RsF9/D3VPnzUjCZtzstFKpkmxBpbFDokZn8
	 naLFCPxaMQ4dXUcpZFvr/j1eUvX68lI+FROH9CX7PKlCuSKw50LJ2JriIvxfaUm23Z
	 TbzuvAXM6gjcQ==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cfd122d78fso345284485a.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 09:19:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOEAuiz1zymZPFsXK2I7RZ+fGD8S4IqdwNCJdSvzDO0ba6lvKaTEUYDpdmHWfvRq3BpPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXQ8vO5TRuCrcCFFYWv1piJhLi0DlqjUBz21pmmiHLo4+0Qlq
	miPSMwfeHVtJZn6X3rEinb/7FkeE2iFV0pKHhGULym0ssplwjeJy+Tw3x7pOsDqVwDVRUK9bq2N
	GdI86nSDzQrVajIrTlt6CzNUrEssdBcA=
X-Received: by 2002:a05:620a:448f:b0:8c7:f79:bd70 with SMTP id
 af79cd13be357-8d41da56c25mr522980485a.44.1775233173869; Fri, 03 Apr 2026
 09:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260402092607.96430-4-laoar.shao@gmail.com>
In-Reply-To: <20260402092607.96430-4-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 3 Apr 2026 09:19:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
X-Gm-Features: AQROBzB_Kb5Pvx8Y-KgoHLBUvvCPfURQUM5KHCLy0CPv5s3H3joA7FSpJ0KtftY
Message-ID: <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 2:26=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> Add a new replaceable attribute to allow the coexistence of both
> atomic-replace and non-atomic-replace livepatches. If replaceable is set =
to
> 0, the livepatch will not be replaced by a subsequent atomic-replace
> operation.
>
> This is a preparatory patch for following changes.

IIRC, the use case for this change is when multiple users load various
livepatch modules on the same system. I still don't believe this is the
right way to manage livepatches. That said, I won't really NACK this
if other folks think this is a useful option.

In case we really want a feature like this, shall we add a replaceable
flag to each function (klp_func)? This will give us fine granularity
control. For example, user A has a non-replaceable livepatch on
func_a; later user B wants to patch another version of func_a. Then
some logic can detect such a conflict and reject the load of user B's
livepatch. Does this make sense?

Thanks,
Song
