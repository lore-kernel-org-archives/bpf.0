Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7851616C
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064031; cv=pass; b=PjMZq/ZD0GWJNDyw8CKT9pBWH1jrFlO+3WVDJTZ0Jn+glYZE07569zFwuw6UrqFQLTNhVNGl1TPdiaK8GUzuEbSB+KBLJCAsh82g1GJCqsJeJDY8XnQAEKqovIdB6wEJq0+CBSUszeW29DUTJ98vVQp4a3ngubaNjCvMUVEUdpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064031; c=relaxed/simple;
	bh=78wXkLFw/SMfWWA5rRLBi3jwnfNyUqDFiIvYEtDeyqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFEj5+ySz5/oyZj1mbRn7GTfakVOUN2oawPU3gtzQekFSMnt344eZhpdR7cxuwzj8cjY4k6lc3vy0HPme8GRg/NJH8ddGkb2dlnfe3qTWXohc3xjEXKBlPnXBso2WQ4IQDrKCnY4W2rZlPiMRtkG3MENN90RNU78QlSTOOTY8Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Glpm5tgr; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Glpm5tgr"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a75f960be4so39721121fa.2
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792064024; cv=none;
        d=google.com; s=arc-20260327;
        b=VXX5cxfLNdZYrzshigmGf2C/LCAGepc2sJ2ZRt3IHTjdTTt62sOwvYbm7jCdFAWeGO
         dx7GHunc10OYevghOEo/AEOfhP7ubbA12TX8KcZH4nnXox4NZuP/1zNZbsB0rkrxdZ8z
         q7lT2QQDhvXb87utejVPhyFOjxDU1CtECgn/F4rRhEEHT+mzjXjObkv1xke/neE5sWwj
         UZNHrRyNEHGqnhg+7ug/dxyaMLMwSyokkE/j1TMTfSVwUc1OOON885BXd/pbZ0DR77MC
         OILBgC+4TCZNWzT9trkmGASgCtK19pLXIpjdfv2oxQvWDLW+k0O7oG+MscYTlcrMR6Ax
         Xq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
        fh=aDTHwUKl8xpmE4CgSt1kL21jr2Hxe6xH0Hc6cT7V0p4=;
        b=dQNFFHDGwzjNbUPa4v3fhICKzEBZec0kAicwkpQ+DbG7luYeeoytEXWipKrDmUUsaM
         1Hrn+vCNsaDz7CpByGByIckk00GH+Ie+pfxCM9jV31LYsyljVwnsBS6gIDvsVU24AWLa
         tScyadAukHboacNoYVQrFlkUTaoVsF+yvsSSiQd1dQMDfiO2SaHloZ/sIAuOi1/gEngY
         QIfgMMMQGZaqS/msbZiI++zEwJK9O994VG7lHDaPtot+smwI4X3LyxVayp/+d8UYCcMs
         7lSJodIHTMjeFM3SxE2O645OxBhRVC5P9LyoeDI59Lr88I172QXodC4DLOKZntZ6WIjv
         gMpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792064024; x=1792668824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
        b=Glpm5tgr46F+Rj5ss+W90tvAuLdiTGjE5ceFkHuKOuxQ3ZBSb4EyZ5ekwzDBlrWRoV
         eHsQpKEz54jPTEV2rUXiSaWEu70hAIuSNJ/HOfIUXw0EsQEhFX5g5mxzIOAr/GyrwTfW
         DWPZGz6ftTdWTnDgKquz9mm+UycxnxNPPLvlOQrDlMZFZaJoAhNOES8SLzFxEdMLBDFs
         dsRUuzpKHV9gFwccCp0mJ80/llf5L+11PwBpbsjgNGtKou2lZfRquydC9yBcAUQ8in3q
         xUDYOzcZTKidnEFEZt7RJtvURtwPNURjGjH/+RKCin9ckKfoub27WEBtBxp89FcDLGnh
         SzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064024; x=1792668824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVkAPVeV3U3Z1r6vn3DHdC0uUky7cOD11NYVy4jKyNM=;
        b=ojt+XD0BbriJbqWiryrrdj1QcUmg/GgA+sqO3BtUy/pXfPau5kWrPyl1nE6zvPgFUi
         klN+qBOtiQF16EnQA/ynOriB4Ep+HLivpW7t7+wQ6PhBtDGUf71h1+8iQX3PMgsS1F6C
         4aRwbpWtyYnvF23MFEGHHipybx+m9T+LJdZJ0Ci1gcJipBbEMH5exJOvlWw1770L0Fv/
         4uDvSsbjhZS0LaHa7lDb6x62vGNB0t8g0ldURYG6RVCJeR8gHCAM5gRzSeIjrfGWE0lK
         7mKlnm8cLJ56s9QJ8yyen+aDTzQVUAc/ESK0xaHUkEfIQ/Tf5LNaVPnsy3ouiCgCHel0
         tF/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwCYH5MspYei6kqPuh5X56Ck+LjpIDXB08qhcZECquGqwLet1XXV5If70ucCLAe+f5HxXI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1ZNbRDgi4wCYuC6FED96fqJ5aYpCLN0LdMCunH+Y1N6t38gAz
	62wSfSN1goTizpIKx6+iVHwx/eYkQFF2F2M+F75Ry8lONsIVnM5ryq1DeIeIoTKCve8DgSpwEkA
	N/avcldPLR8mvVZl4CwiTtObVGeE5X1pKBsYKgc7QL2w=
X-Gm-Gg: AYBFou2snNa1flPa4LGLQ6NpDFK1IsR0NgHhFVKnI+4Gl+17QFG6dBMYNhCFMYr+zt6
	kz+TYw3eH3e7V/77BIeBS4mg7WomoVj1QP2HNJPXO3azeABz3x4bv8YPgIT23MA5kPYB2sGG04X
	8lTufzROCzKYR10J7BhMj2t3kK7opga2HreWClmlEYEoWD0Lw6ZYCtuy+tvcIGirD/GQ/KTQjhP
	PbmE71QF7g5TWvLp8bSz48wLKltOQDc2Zu4D053iOOwL6SEhNSzyjQpguyI/pmQMceq0rMjxcpg
	BnTXgJSHerkjsQgscOWHp/0B/UpiH8giWtkn/7IxWIKyDFixeb/+c7JdSfipMNYKyif9ae6sDH9
	F07hW4B2srQ==
X-Received: by 2002:a2e:b019:0:b0:3a6:53b7:65f with SMTP id
 38308e7fff4ca-3a9c56e2e18mr32007541fa.24.1792064023930; Thu, 15 Oct 2026
 04:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792048855.git.zihanx@nebusec.ai> <atCtUFcG9b4ykXY3@strlen.de>
In-Reply-To: <atCtUFcG9b4ykXY3@strlen.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Thu, 15 Oct 2026 19:33:31 +0800
X-Gm-Features: AclHuK_8_Kk2IIVBq5gfnontRtGKaffdTFvzSUc3-5H_TGMTs9I-jfqzlZDWd3I
Message-ID: <CAANe3eS=72iEkSwLGToMZmv_Drk3Naky2OL8oM_11GZztR3s4g@mail.gmail.com>
Subject: Re: [PATCH nf v8 0/3] netfilter: bound asynchronous packet duplication
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, virtualization@lists.linux.dev, 
	intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org, pablo@netfilter.org, 
	phil@nwl.cc, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kaber@trash.net, jengelh@medozas.de, andrew+netdev@lunn.ch, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, aleksander.lobakin@intel.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	willemb@google.com, alice.kernel@fastmail.im, eilaimemedsnaimel@gmail.com, 
	imv4bel@gmail.com, shiming.cheng@mediatek.com, sd@queasysnail.net, 
	vega@nebusec.ai, root@tr0jan.top
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 6:39=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Zihan Xi <zihanx@nebusec.ai> wrote:
> > Hi Linux kernel maintainers,
> >
> > We found and validated an issue in netfilter packet duplication. The bu=
g
> > is reachable by an unprivileged user in user and network namespaces.
> > Bounded tests exercised the fixes. Non-duplication packet semantics are
> > intended to remain unchanged. MIRRED flow offload for affected netdev d=
up
> > rules is rejected because it cannot enforce the duplication-depth limit=
.
> >
> > We will provide detailed information about the bug
> > in this email, along with a PoC to trigger it.
>
> Series makes no sense to me, sorry.  I dislike the 2nd patch, I see no
> reason why we need to make changes all over the place for this...?
>
> Also, if we go with 2nd patch, why do we still need the first?
>
> > The IPv4 and IPv6 duplication helpers use a task-local guard while a cl=
oned
> > packet traverses output hooks. If NFQUEUE suspends that traversal, the
> > output call can return and clear the guard before a later verdict resum=
es
> > the remaining hooks. The resumed packet can reach another duplication
> > consumer without the original guard. This can cause repeated packet
> > processing and consume CPU and network resources.
>
> "Don't do that, then"?
>
> I think the kernel should not crash when misused, but I don't think
> kernel should have to do extreme stunts to detect such loops.
>
> There are probably many other ways to make kernel allocate lots of
> memory or waste cpu cycles.
>
> E.g. via create use of veth and bridges, sched plug, teql, ...
>
> > Patch 1 records the
> > guard in the queue entry and restores it during reinjection. It keeps
> > bottom halves disabled during the reinjection traversal, restoring the
> > verdict task state before reenabling them.
>
> Its small enough, so I have no objections to this patch.
>
> > The netdev nft dup path has a separate synchronous transmit recursion
> > counter. It does not accompany a duplicated skb through asynchronous
> > software receive paths. Patch 2 carries a bounded duplication depth thr=
ough
> > skb and supported XDP conversions, resets it on reused buffers, and rej=
ects
> > MIRRED flow offload where the software depth cannot be enforced. This s=
cope
> > covers software skb/XDP continuity, not packet loops through physical
> > hardware or userspace device round trips.
>
> I think it would be better to first go to the drawing board and make ONE
> facility that governs the recursion part.
>
> From a quick glance, the difference is historical from time when
> per-module pcpu counters were used, so nf_dup netdev could not see the st=
ate
> of nft_dup toggle.  Now that its in task struct anyway, maybe its time to
> just zap the egress recursion counter and first make a patch that
> uses the bool toggle for both egress and normal dup?
>
> I would like to remove code, not add more.
>
> > At PRE_ROUTING and LOCAL_IN, the IPv4 and IPv6 helpers decrement TTL or
> > hop limit on the copy. Patch 3 stops creating copies when the value is
> > <=3D 1, so the decrement cannot reach zero or wrap a zero value to the
> > maximum.
>
> Thats unrelated problem.  There are other places that do TTL/HL
> decrements.  I think it makes sense to clean this up in -next and
> add common helpers and then use those.

Hi Florian,

Thanks for taking the time to review this series. Your comments make
clear that I have not yet presented a sufficiently simple, coherent
design, particularly why both patches 1 and 2 are needed.

I will go back to the recursion-guard design and first evaluate
whether the existing current->in_nf_duplicate flag can be used by both
the IPv4/IPv6 and netdev duplication paths, replacing the separate
egress recursion counter. I will check the effects on the counter=E2=80=99s
other users and verify the relevant egress, bottom-half, and
asynchronous receive paths before deciding whether a task-local flag
is sufficient. I will not assume that it covers asynchronous paths
without evidence.

I understand that you have no objection to patch 1 on its own. I will
nevertheless check whether the unified design makes its NFQUEUE
queue-entry state redundant; if not, I will keep that change limited
to the NFQUEUE state-lifetimeissue.

I agree that the TTL/hop-limit change is separate from this series. I
will leave it out and consider it independently alongside the
common-helper work in -next.

I also take your point about scope: the goal should be a simple,
coherent recursion guard for this duplication behavior, not a general
mechanism for detecting every possible source of CPU or memory
consumption. I will return with the path analysis and a smaller design
before sending another series.

Best regards,
Zihan
