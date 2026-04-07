Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D226290
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525696; cv=pass; b=hc54VQPFGxbjTeGyLvqNdCOHWTyddPt6jiOWW9UL9CQQpl1iLo9CyNnlbeRCJ9XS5Zkdwe5QaXjQGrSAN8OZfN06qe9hYjj8U5wmhMZl5WmxD6oqTMd1/wbBW5gQUjhXfaZwO4Qh2PLQgAtRsTSrEOS3fU+sVPuA0eX/e1U1p8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525696; c=relaxed/simple;
	bh=CdjNKl6RvdEAH7DQmoeHpr7AGXr1Jb08XVC3ztHNxVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5PsfHigXpf3WVvQA69LLJshEd9omDJUXmX8AzOwJc1O8Tbb0dqgcCWV4nh1cEaeK8fPRkFuq2SWehYVTkDAl1OPIvy6YfgsU4WwdlSjSzlZEf1ktSCn88jV8Emo3x1QyxpFg2Xf8mPnyzzGczqWsvyL2cC2wNjB/VGyjbwiFbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcWLxV+c; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcWLxV+c"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7986e538decso45731987b3.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 18:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775525694; cv=none;
        d=google.com; s=arc-20240605;
        b=WMot/Id16yoydcYGRD1l02el2vDBvf2pCWQI8CNrLJGBfCRGMdN+2zbaOr4M7Li5xy
         S/cjTMcVUCAo9qGIzIhJl6HGSblUHbilamjaoeHaZ058eBmGqZhODj7lE4jk9bdJruUb
         XJkRK61qMUKUjRgs2ZCGbUzmhUbX4+/67Be9nhR+aPJMIxl1yqPSxQk8Fbe2YdPFEwMd
         qMZk42SrK0G9i1l0cgm+o9FUxf7NN6m9YHYB7SOqo4Djz5QAnbwNfqXkZX5YmA32P019
         JoD8e2jyI+AprZtsps1KU+T2u7z49VM2Z0mRMJhWLHE0ZvcsykZFS+ZiVpReIoEZaZUP
         jx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gOQ/7d8DzPMY6Lf5FjM6QVlbxIIMJf+rrNRaxjRBQZo=;
        fh=GcNjIGaYXYO9RDYjXa34iJIXldrGdFwTtHYIiUWFrZc=;
        b=GuBkrEHV8fhYQMiz/ifKFSiWhpFW+7lip8qSfIK/u5sCx8/skGfOqj4Nuh1iCY5WvB
         6iFwTr4XpY1E4A6uGhGGsN2dCCZ7Vfjh6T86U79gmMAnvl6j8dOvGO+llvffFi4YKQdy
         dCSRRyPvIe2XqFW5a/ia6iz+7r6YGV2YqgV520De+o04iEzFK9XnLwsSaAjHuMLeI2tV
         hXBH02vhaeLBE6t+bDl9Q7LQAxiOE7wpXzkTc5WLSEzbxUZHdOu5xWWu5uv5Co/mIILr
         nQOedLqzEu5pUt/I+9AFLOF000VJAfAcEqZ3K4dJKPaXXisJCB4NM1zLldhZi7D9xd+4
         h1vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775525694; x=1776130494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOQ/7d8DzPMY6Lf5FjM6QVlbxIIMJf+rrNRaxjRBQZo=;
        b=dcWLxV+c7sNj1Mt26ZSPDjOh4nvp5U4/4gsLwSnif7FwaixOHnG20msivSBboeTKwI
         sxPtLOwtpFiPHWaAr/MUYqm3pf5MvCNvb2nuTGi7V3uGs7k/BvePNR1MCJOuhP/JD9J2
         W0qqn6ZyKdu25WLmmEF+tL5qrYnNf0fpgeMK9hnqo/RaJMiPzjCeh6fNxfNaDtU6Wr7/
         aw+oV6RBXPeHe3OL9uXev9n448WFQMjyRTTgd9c7JBCHLMLxbJVsvnCf4RH2PXYWsiDv
         8mug6B89myCUQoZJHWXQDGaQUhdll8eRNSWZkZf2oF8eDbT8FppW7JcqNF50Vv1mCzes
         HKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525694; x=1776130494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOQ/7d8DzPMY6Lf5FjM6QVlbxIIMJf+rrNRaxjRBQZo=;
        b=Np+K6TKnzUWTSEeN0O3yjEO8BWQQbDa11TawS49t/vrB1lypBYifHT6iZGSbVW0qIF
         K/SULrIoC9+MetueKv4tw2w7CpRuIBrTNYwXziOcmIp/Yp54huFv8GHhbDqqDcodoc0z
         +S6w+EBI8KT3eCShrN12MuiTbaUt+MK9Hi5MkWerO7WtTj9GVBOnm7cwmwZV2X+U3MXZ
         0ZvvvgnYqUbW3f6W+q05PLnARt2pv3XFvuR2a9fUdv5NKgo0xPR9lbuus71yx0X/mUM6
         zh06hAxErtxe3eH0/t+IK1OTOfSaC+LiCBUQlogU7Mh3wlOzJ8UpuHiu1RKFHY+xxAlR
         3sTw==
X-Forwarded-Encrypted: i=1; AJvYcCVIu8Oxde8Zm9Rrd+LwuwnjNxaB5PVoOhvdbfwpzwTMdCfEYt+apQkHka+3NFaHg0Ki7VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3PhtJ8jsV6dIv+Gl6lUtAyB6BB815Dd6Dp6uGVt9Jofn7ANjt
	8dzzJ5gyt3T8ujfr4XJRjdvcNu7GJgvoi+oWSOGh0Nto6xRIO6IfUOpJ0PQhQQP1j0rxmuh2mSd
	+BlUxA0i9Losub6u//pmBU9PWsEJg7eo=
X-Gm-Gg: AeBDieuOjDNWs6cQA3RsND+I3lK8kjPXuhlt7mM2fYYkwvT7j40shGty/535YOZCC2W
	JV8QPAe3EIbWVwkXdraPUn/4tCW6lxXQ3hjk59b2mJimOFCATCkgP9Lg4MH5vk0gQnDa2cj3kz9
	GcZ+vYsh33xRr1sYFd5XArOlJfXIfd18gCKbjuvVBmrspTeN5j0NvcazocyDxq93YW3vCGxQqmT
	vzibEk1Oxc8vIlihFTjfOM7lWCasD5PQ78y4RxNufV0TC4aGwBnnKYfbKOXO0jQTg61NiAL0wSp
	r20vND9AC3MAtE+viOdOsGRulKyCdLKMi7qlgwkVQbgmGHCJvws=
X-Received: by 2002:a05:690c:4806:b0:79a:7ff5:93c4 with SMTP id
 00721157ae682-7a4d6b311bbmr150352887b3.18.1775525693949; Mon, 06 Apr 2026
 18:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402160147.215499-1-sun.jian.kdev@gmail.com> <202646183934.lJx5.martin.lau@linux.dev>
In-Reply-To: <202646183934.lJx5.martin.lau@linux.dev>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 7 Apr 2026 09:34:44 +0800
X-Gm-Features: AQROBzDEHcZwUn6RnkKIGl5W4d3QSCPFqo_CJP6vIqbrvoH3IIXffE6vzY6oLWQ
Message-ID: <CABFUUZF_CWQZrRk=L9cNxO=8Z4iSgGfXi3J=hpzeyTKDbfE2-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, 
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 2:58=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On Fri, Apr 03, 2026 at 12:01:47AM +0800, Sun Jian wrote:
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 178c4738e63b..300e2bfc5a62 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -1120,19 +1120,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog=
, const union bpf_attr *kattr,
> >
> >       switch (skb->protocol) {
> >       case htons(ETH_P_IP):
> > -             sk->sk_family =3D AF_INET;
> > -             if (sizeof(struct iphdr) <=3D skb_headlen(skb)) {
> > -                     sk->sk_rcv_saddr =3D ip_hdr(skb)->saddr;
> > -                     sk->sk_daddr =3D ip_hdr(skb)->daddr;
> > +             if (skb_headlen(skb) < sizeof(struct iphdr)) {
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> >               }
> > +             sk->sk_family =3D AF_INET;
> > +             sk->sk_rcv_saddr =3D ip_hdr(skb)->saddr;
> > +             sk->sk_daddr =3D ip_hdr(skb)->daddr;
> >               break;
> >  #if IS_ENABLED(CONFIG_IPV6)
> >       case htons(ETH_P_IPV6):
> > -             sk->sk_family =3D AF_INET6;
> > -             if (sizeof(struct ipv6hdr) <=3D skb_headlen(skb)) {
> > -                     sk->sk_v6_rcv_saddr =3D ipv6_hdr(skb)->saddr;
> > -                     sk->sk_v6_daddr =3D ipv6_hdr(skb)->daddr;
> > +             if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> >               }
> > +             sk->sk_family =3D AF_INET6;
> > +             sk->sk_v6_rcv_saddr =3D ipv6_hdr(skb)->saddr;
> > +             sk->sk_v6_daddr =3D ipv6_hdr(skb)->daddr;
> >               break;
> >  #endif
> >       default:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools=
/testing/selftests/bpf/prog_tests/empty_skb.c
> > index 438583e1f2d1..d53567e9cd77 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> > @@ -12,6 +12,8 @@ void test_empty_skb(void)
> >       struct bpf_program *prog;
> >       char eth_hlen_pp[15];
> >       char eth_hlen[14];
> > +     char ipv4_eth_hlen[14];
> > +     char ipv6_eth_hlen[14];
>
> The eth_hlen_pp and eth_hlen needs to memset zero now.
>
> Instead of adding two more ethhdrs, just reuse the current eth_hlen and
> define it as 'struct ethhdr eth_hlen;' instead of a char array.
> Add 'h_proto' to the anonymous 'struct { } tests[]'.  Initialize
> the eth_hlen.h_proto based on the tests[i].h_proto.
>
> Also, this test does not actually reproduce the reading uninit memeory.
> It needs a bpf prog to actually trigger it by calling bpf_skb_adjust_room=
()
> based on the report in the "Closes" link. The test should be able
> to trigger it without the change in test_run.c
>
> The ai-review has flagged again that it is missing a "Fixes" tag. This
> probably started since the bpf_skb_adjust_room helper was introduced.
>
> The selftests should also be in a separate patch 2 following the patch 1
> changes in test_run.c.
>
> pw-bot: cr

Ack. I'll split this into two patches and rework the selftest accordingly.
