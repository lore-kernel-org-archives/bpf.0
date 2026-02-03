Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C82219A8E
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081504; cv=pass; b=sjxQTZ6t6hcN7B8VRP0GtisH5m7ohqzkQmbNZmBdWKh9urXtDd7aaXrYOg7xg10LtrpaUytjKq1pU8w1XOSSZmlBNodoFeqJ5Hj/MDA1pmMqoBOWAj5UGDii5zYiW3J7smLovmGMWGe8dM1gSJ2XhaMvRIRtj4lIWm3MS352GQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081504; c=relaxed/simple;
	bh=Bmmhefj4WNLudxlkW4jKO5VYo++HONTS5JYUhkUAUgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tgo7FiyZCH1f8jlKUZH7Wo1muWJ3HJoE+xjH/nkMsljY4PwLMM79AXx8Omz2wh8cfq/dqhRjDpx9dwC4Ne7pEWaw5cE9C62bkvTSgW3SVg7Zeexlp3zwdBo/5X8VqFecC84qVDuMOogRlffPQcKAcc8JpUA5B248etdYA7YlClw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wbz4nT+j; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbz4nT+j"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-435903c4040so3372348f8f.3
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 17:18:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770081501; cv=none;
        d=google.com; s=arc-20240605;
        b=ME1bg9wUgL8BQwZiLblKWMnyDeG9nhD77yNdu4ZLVd3M3nu8S8VRB4U65PUWi1MBFk
         vRWDmD9BXn+1JKCamLgs5B0mJao9iJ6lFPMnUpYGQO9VNFZbsrw7aYDIIs+MHNGma+a2
         M8xj1SgrNW1tChqwSjawOsyu5SQ+bHHmuZ9RvecFPf09gJSkkmAR5PUjAlaXkrTauYH2
         y7IgSq8T1dxscIQpGTldsJf4oMYf/hdA6hxkeMYlYCzXxMsa+/07XoK/CjiVgw1KPH4M
         NDkvcZ3UgRIOFLz4NcsnVfbVUbPjhSLO+sNEY3aKnRQGvVxvndnpsAEopVsPo4q/pkxD
         T27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sd/d8SeUvWXvlGk9ddIMYzI+tIG2toE3t6Ukc4jQMvk=;
        fh=HuH0psSsCYsWPnIAYtMbKziaCRRdQz9xdan32gthsHM=;
        b=OIpf8/dUV/ge/xCeXgH2ziMrrdTibuZvo372RMOWU3pgbtz+IuovPLWuNX7Add3Rtb
         BnToUxsUsDNb9YJ3JphlHi3VJyauVLHuzE5YHuunfRFOluJBRJCua3ZP58BvfsJlw6zr
         ilaZoy5esgXM1RGwOmVFh959JaRItL9ZxfLPyeP0EWpKR3suoizRdn4LN8pZVTkC51nQ
         Hug2DCcWGcEx/G3LsR02MoeN7OJFC1kTwwJFyx1xbGCXMTJ/EVCn6+oRtfAuQnSR3guQ
         UQ1gCnhchjubkmtzCcphfahuwIHi+Vk4CFs1iN/xJn9cS3UbXUY3+K/Wc9RloTUGbC0U
         689g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770081501; x=1770686301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd/d8SeUvWXvlGk9ddIMYzI+tIG2toE3t6Ukc4jQMvk=;
        b=Wbz4nT+jhzBYIUKsP1eW5DHclBcI9vLSeb3sM1zIRAf04OdeLq7WRWRNOpC1Ci2f17
         +ZeVpJUn+mpJd/8Zbklo4wqB2VSQWQ2WADbTzTNWMoFL5mf85P12AZsgRNNjWCXvpAXQ
         y9MGGAWIg5BAVEwr0A0pXDxz0ff/yWYW6ctpAp/IssyAqmpDYU9aDJUf9a/YG3mc6xOF
         pn6CpI2Oq+yhET/ziaNS5iug3R4i7lDDMj9RkMr1caIrFbF5bj5zsKVfsWAnv2iai9kP
         AnL2UABdLXUC0HAxrvNDHhne4CxG0lQAzSdIwvrdc5bETIMopKCJcG0BNTu/Ei5RA9o3
         2cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770081501; x=1770686301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sd/d8SeUvWXvlGk9ddIMYzI+tIG2toE3t6Ukc4jQMvk=;
        b=MboljVT31y+jIvMwGoC2gUwEk9SZKFP8wiS98T67DiW+m0CUksOWsrX82Abk2q4bF+
         PM1wuk5eRHFTa7IzXe41jXTG62Q7amnNYhbwnDmNwqygEs7Fn3DJs8YwQXKXV8oTCOAO
         Vio31k+h3lD0IYDUOI+x8NUIVXlaOUb+4ebrWj/D5AgfMHFE7arQpyoqUA5ugH3cN77Y
         5O2bVdBSClyMoqgCRvf96troejvHXD5tKW5lYOvcbVUvuU8z5I2vnK+acUmJ+GtVswYW
         i11kvX+K+e8WOgMwRsVZPzhbfT7EM0LDNAEc9xKkDkkm8CLN1dro1kr6OdJBHjvDcs8p
         owdA==
X-Forwarded-Encrypted: i=1; AJvYcCUvbppPJvJjvsCSbkCmxq9SQe56TXZAelWZ7fxIhUuhaabO8O7wR2pMNS1JIreKMa4tZro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pTDLHNw/o4edqQAuPrZGK6cdE1tPw7ike2fOeoOTl485Dnus
	mGQsl2XwhZeLTM+KAcIW/x9NPf1OmuDIrYJ39FdXs++1DaRRtmdHvYAYTVEx5GGY5g/DlbtRPkD
	JbmkzrNIPW20+nBPmHUG1kmdPf0qUA+Y=
X-Gm-Gg: AZuq6aJgOFPJzAbNbP6D4OjBPQDcJDS0eBqLoroBwrNlIlVw+qqkMqugiCT1B0SJXIF
	nROtASCf8wm3bKAM+q284SUapDhLgAXxI0k6nQ03mGyhYVe5INxH5ovbPUYCaxhjdEXTkRnof7W
	L1WWRUSr4gzGahakS1pPXuozHUYMi8YndWXbBaSYxxJMhZubKEqCmmx/+Fyaz6TU/SwIfe7nuqW
	DoA3wRAWbCiI7VMo74sz0za+7aJHnvWBxVpYPrI35tqRwliS/nt5ynyIcDbLXLyYoBN4y0jftKj
	hdR59HN2udJRz7EZwafUHRn6jPHOgKKdz7BuEzbk45E08LoCdrgi7K554BPCb8ptMIVEFrWRXsw
	Uoeu2Tcd2k+7hmg==
X-Received: by 2002:a05:6000:26cd:b0:430:f7c9:94c3 with SMTP id
 ffacd0b85a97d-435f3a864dcmr20856195f8f.25.1770081501267; Mon, 02 Feb 2026
 17:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202090051.87802-1-pilgrimtao@gmail.com> <20260202090051.87802-2-pilgrimtao@gmail.com>
 <CAADnVQJPFANbYvYYyG3OQdXh4174bGwsamAzD8HZ5f=noS=BnQ@mail.gmail.com> <CAAWJmAaiFAyK+PDLStoR_0sGAH6TeeekPMdOjhKwQ07rUm_oSA@mail.gmail.com>
In-Reply-To: <CAAWJmAaiFAyK+PDLStoR_0sGAH6TeeekPMdOjhKwQ07rUm_oSA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Feb 2026 17:18:10 -0800
X-Gm-Features: AZwV_Qg8XA7JUMiNc7JyuqWoaZbv30QGWKAtdBVvQXzrT4x-mLO7ytNlIyiFJro
Message-ID: <CAADnVQ+R-A1G7JO874fASUQNvDYuTeWovyvriCPth40Y=oLc9w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] bpf/verifier: allow calling bpf_kptr_xchg while
 holding a lock
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 5:14=E2=80=AFPM Chengkaitao <pilgrimtao@gmail.com> w=
rote:
>
> On Tue, Feb 3, 2026 at 1:57=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 2, 2026 at 1:01=E2=80=AFAM Chengkaitao <pilgrimtao@gmail.co=
m> wrote:
> > >
> > > From: Chengkaitao <chengkaitao@kylinos.cn>
> > >
> > > For the following scenario:
> > > struct tree_node {
> > >     struct bpf_rb_node node;
> > >     struct request __kptr *req;
> > >     u64 key;
> > > };
> > > struct bpf_rb_root tree_root __contains(tree_node, node);
> > > struct bpf_spin_lock tree_lock;
> > >
> > > If we need to traverse all nodes in the rbtree, retrieve the __kptr
> > > pointer from each node, and read kernel data from the referenced
> > > object, using bpf_kptr_xchg appears unavoidable.
> > >
> > > This patch skips the BPF verifier checks for bpf_kptr_xchg when
> > > called while holding a lock.
> > >
> > > Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> >
> > You ignored earlier feedback. This is not ok.
> >
> It's my full name. Every region has its own customs and traditions,
> so this isn't an essential change.

We cannot accept your patch then.
SOB has to be "Firstname Lastname"
