Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943828;
	b=3kVHPzMrKvLa2YnI9Vosgf+Y99649M7D2MHvG/a9UQskOrAXtychj3ud9/N7/ARJuXIF
	 dDGK2CuB6G0g1LICWeipqco1Qn4W8qWjQeBTs5rcRxAG3vzRHcmJN8zGO22xbkoujEol7
	 UA3tjDD0iwbmM9ScejoluhA9SVv55z6g3FXScT+OnUl42Q/7K5A9axXXBXqn2u+SDcODb
	 sOuQgtikYcJhB2a4wuKJw4ALhLY86zbqiO0zvnx9IIj1dCK6CITucv9lEbVtnTcpec0dA
	 AtaTobLjSNN1LWMjah11pmjp9NijIM8a97SZBaSdGnf6fETZYxTGvqRMX7u48ogRhqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sj3hBjgFsqV+K2H84i9mKjEVi7Hj254h9Ue/yqcHRR8=;
	b=mWqfSmvl/SWKkrmg6nXSkrwyuci4AF055RMeeIGRtan7S5OduIqZdvsjbKbOpjNQWA6n
	 iJE7baVVeTnRkK4PshobpV0YeEiu6VmtZPDmc7obsXRaKWUSfpfLBaFooCgvGkdXjfh4+
	 HSZNpSQEfbYQCS6zlD05fnILcn6MYUXXQOAFQAzjUkH6Rd+DTY+JWfRH0hoepCt9NRazC
	 t9XyDtQHL9juKXtPE3C+YS6qyJu+AEb8JtYuPjJopJfJ7BX7ul0awRGLWpCTyCX2pzb5I
	 g66I2vkM7yMDewSIwMeTnXA/9OvEIgZ5iN7iQZHgh7KGKucqgc9Db0hmyvIy5iTF4nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=VR8IlJuU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412CD606A32A
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 19:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 412CD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=VR8IlJuU
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-89d6bd67045so50276b3a.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 11:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794943827; cv=none;
        d=google.com; s=arc-20260327;
        b=gBJiwPzok8oIg+nqDLIlyAcy5omy6WIil/QwxXoA3KpYjrY7vTlyDiha6QaAfZ30Ne
         Bw7dem5+dndPap1924ygDlCEkuSVg/7CE3fApbxfKLwzJ7PmbyuMFh5lpCCqdhnlYpYb
         H1EqoQJoXmzJHHE9mgpWn7ZU8Vcf8hu4JYo14e3namjO//EQqNGdQOOAPY1yD2AUKQNk
         YFB2xMLyIqwppBZo0FbQZa6qQ4n6Cx8vgUXjJ6LaNOGcE9Nfhk1KPySE5Hq01rL1GHUC
         yVSvtZfYN4GURSeBysvfumwW/52FaVMm7Hxx1wDe0pSinniF4UozltQfqzxGa317RQGu
         6SuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sj3hBjgFsqV+K2H84i9mKjEVi7Hj254h9Ue/yqcHRR8=;
        fh=a/kl9pwQlRa72DsbPS2NODc2ufvM6XRbgoQPX1E3ttQ=;
        b=eOv2UE/wbTTxzzfaIm/MZ9st861pIKZS61uuWAX8YgoCSsbA7jS+CU1X5wpOB6p49v
         gcQMbK8Oxl9i9vu1G/Kl+mBhfyTAi7i7ZmXvJo8GgmFIZViQYvq38HXgwCKVAJjFF8OF
         rf7+d9qjUrPvJBHNjijqljr4fHOOX8cB+X7v05XUA2yBXMRu3xS7cJVnNQdyaTElUr7j
         6am5GZtSp1LWa6BRLKNPPaHr2IYf6tryBr/M56PTKWGxEwDC620JfcC4url/jgXObx9A
         8Me6RHFryrmqYh/spL9IWgiWeh6zutV7/QqRzDPSVtbulF/r1dhbAuwd4Ka3wRlVb6vo
         T82g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794943827; x=1795548627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sj3hBjgFsqV+K2H84i9mKjEVi7Hj254h9Ue/yqcHRR8=;
        b=VR8IlJuUxEu9TYzVDniE5LhVZ+4g7Nr7Fd7jiQAG2y+N/K5TwpW3dJQNxvjxL9x9Yc
         +/LAooYdXV5cRrLaQgZlAAgRbONAt9gBIuqKMTtyIvJByYGewNc0cGzjkkJlCyenH09E
         73gfP+kxEkfcIEEdvAjz8Xt6zrVvuiIIqhOx1qZYt6o/SQYoeIeiSGiuTqScWZhhCCO7
         U4QMhJAeN1EXrwhX92FMUIb7d+vlrGGqcG+Tvg2bxgxRo6DIj1686baaVBKFXKA2ef6+
         3qPQ6s2zWSAqNdbNHheWFCbTUdmtVaxhlKbtz/qkAp7qAPyaoR+Xq638oKhLGTwZ3fjO
         gNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943827; x=1795548627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sj3hBjgFsqV+K2H84i9mKjEVi7Hj254h9Ue/yqcHRR8=;
        b=IB3ScL5KxkHOQr1V3XEtv/MWF35xhmo5S3YOCia+vs+Md6yVQreJMoJg0OjEaCzoZf
         3ksPfJOGht5xzNi/vXB0gFfbZjMGTD7J7Lmanw+aKqu73YzSJKpmt14atqp0DiWp2D1/
         87IjNu3/9CXXUQ68LxG6HtMXyDtztoCb3M88tbWmUBQ2LPqZ8cCBf2bAx6VqAIuBmogs
         rGTzQVQgdNtUz8ZhhZrHz73JwjCe+ukcGcO4hdKxxhjiElmfY/ozQEuPabTHU+8eNurT
         O0oldegWsMcm/7f1hLHfqbGPFx5hHWtvDuw8rwbwAsbTqkV9TWaGch4dr0IjjuvJ4kpN
         dP3w==
X-Forwarded-Encrypted: i=1; AL+hErFk3DpWbpeyTjJTCzWpySlMjyCmvC9AllqcSXkiuYZ5VLtnez4ovtMzGMouW+jBhC6Y0J0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8k2qOh3O+DAi3sDx9nGufrq1mhghdeQioPfS43dzRyXtttvj98
	zIsog3X7+N9O+BVQS4iLB+vRYAOk+I03pDtydu0eraoIz7yZBpmSClaXngbSpLDQLlCPHoovgKC
	/3xaWeLjivciSU2UXUBP7Js+PUXB2CulidMpd153S
X-Gm-Gg: AYBFou2nP9P0EI7qhfiZJQtL2ir9R7bF8/yu9aQ6guAE/Bu77ALAyt02wLu3zlWbBDf
	3qqmK4M3ObpMcGwRg05w9fEc8lm4MItChB+SqczdLkH1Jz4//JK4vsaA7jJqnMznL9XEQq6loVz
	qvLCrAvZP8ssDKXQ61sB4kk0zjNhD07LYB6bieRWYw2sFu/A9BfgGC34YaididRmOkRLcqKY9lf
	oRpgpGFax9gLQRI98UvPKpssLUZJicLtoOW6QPeAsGQ9e9AxU+to+mA1aQd0nyXEAx5jpv2hGUQ
	jRRYHUiPnyUDLShvLiMuGob/E5LmrE2t7faGGMLYnyncgooHzG+TrPZJU6aLwA6aAeH9/sSupY8
	i+u5/SviIVysCb47QOqIYIJjoGp9+vH6k/4KLYw+hRGlVgZad4qkJYwTQDJvfboT2CqxQ
X-Received: by 2002:a05:6a00:1f11:b0:8b5:a10a:a3e8 with SMTP id
 d2e1a72fcca58-8c457e2e17amr2269626b3a.44.1794943827559; Tue, 17 Nov 2026
 11:30:27 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <CAEf4Bzb+oYDqO20v4YbJ45wdtcGgJT3xVse822P+=oA7fpFAOA@mail.gmail.com>
 <CAHC9VhRcT3rmdpeadwi2avhwvr7aEZYStZ3bbEEx1hm=wtBGhQ@mail.gmail.com> <CAEf4BzZ120age2-M-a_TJ07xohb7-s=xn3e1W_-V0kopnATq6A@mail.gmail.com>
In-Reply-To: <CAEf4BzZ120age2-M-a_TJ07xohb7-s=xn3e1W_-V0kopnATq6A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Nov 2026 14:30:15 -0500
X-Gm-Features: AclHuK-RtKReAlxzWgT2ghpIFsZj6qbY4_JP5P0ehVqwzT5eB9L_2z4RTCFLPcA
Message-ID: <CAHC9VhThV9xiXr8j5_+W__CBKn0JqUiZ-RGZpF4Nz-i_RZprAQ@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: roblabla <linux@roblab.la>, Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:51=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Thu, Nov 12, 2026 at 6:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Nov 12, 2026 at 6:00=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Mon, Nov 9, 2026 at 7:08=E2=80=AFAM roblabla <linux@roblab.la> wro=
te:
> > > >
> > > > Hi,
> > > >
> > > > Thanks for the replies!
> > > >
> > > > > LSMs that need to provide a stable API must provide an abstractio=
n
> > > > > layer between the LSM hook callbacks and their stable API.  The L=
SM
> > > > > framework is not responsible for the stability of individual LSM =
APIs.
> > > >
> > > > Understood, that lines up with my expectations. I think the biggest
> > > > thing here would not necessarily be stability guarantees, but rathe=
r to
> > > > make sure that the eBPFs fail to load when the compatibility is bro=
ken.
> > > > But that's probably a problem for the eBPF side, and not LSM, I ass=
ume.
> > > >
> > > > > So, in short, would it be possible to send a follow up to Daan's
> > > > > commit and move `struct mnt_idmap *idmap` to the end of LSM argum=
ent
> > > > > list?
> > > >
> > > > If this is possible, that'd be nice so that we avoid this breakage =
in
> > > > the short term, since the change isn't in a released kernel yet.
> > >
> > > can you please send a patch proposing that and we can continue
> > > discussion there? please cc me so I can follow along
> >
> > Considering the original patch was submitted, reviewed, and merged
> > with the BPF LSM being the only user (none of the existing in-tree
> > LSMs use the idmap parameter at present), I'm a little surprised this
> > wasn't brought up earlier.
>
> Yeah, unfortunately this was missed. Not sure it's surprising that it
> wasn't detected immediately, though, because unlikely someone tested
> an unreleased kernel in production. Luckily, this was still detected
> early enough before the final release and this gives us a chance to
> fix a mistake.

I've been surprised lately by apparently how little the BPF LSM
program interface is tested with real BPF programs before landing in
Linus' tree.  I know the BPF folks have a pretty good set of CI tests,
bots, etc. but there do seem to be gaps relating to real world usage.

> > Beyond that, from a style perspective, I think I prefer the idmap at
> > the front of the parameter list in most (all?) of the hooks where it
> > was added.  I'm not interested in moving it at this point in time.
>
> So on one hand we have a real user pain which is easily fixable
> without burdening kernel and LSM subsystem in particular, right?

Arguably changes that negatively impact code style and readability do
affect developers and maintainers.

> On
> the other hand there is a minor issue of argument ordering with
> mnt_idmap preferably as a first argument. I get the preference, but I
> think fixing an unnecessary (but easily fixable!) user pain should
> come first, don't you agree?
>
> Can you please reconsider?

The user pain exists because there is no abstraction layer between the
LSM hook callbacks and what the BPF LSM makes available to BPF
programs.  That's a choice made by the BPF LSM devs, and while it's a
valid choice, it does have drawbacks like we are seeing here.  Changes
to the callback arguments and/or the semantic behavior of the LSM
hooks are going to continue to happen regardless of what we do here.
It's better if the BPF LSM figures out how to deal with problems like
these rather than relying on a set of bandaids at the LSM framework
layer.  If the decision is to push the pain up to the user to keep the
BPF program interface thin and flexible, that is their choice.

--=20
paul-moore.com
