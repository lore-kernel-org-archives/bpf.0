Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E031145B27
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460008; cv=pass; b=KiJosg6CljITDDde078H58/fRDFQB94JhJSQZ/oLDwLZ2I77RHljId8j+S9lluE+NS6NNZLxML4OI3x2MmMd+rBZVpsU7oAJyW7p2rB8fVr3HCKLeH39VJ6ipzhyCRXI9LTflg7+7c0t7BKSpf29i1KoIHLU7v3rOqyFXprOrQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460008; c=relaxed/simple;
	bh=3aSJo7NI0/BigI7Mtd/Ltf6FSWBj3N6e3vsgJQ9x/yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Az4TurmJVbM+AlT0IYBGAWenANjpDKgvoxby/gLY1HhU0W0MSpQzMuyi8fcmi2TTPvRHlpl/vSc0dXuHRUG4BSz8jNR2LkiGH7j9P3jRnjQAB+76Us4zeqcbZ6pCAZ1/96dE6UDb5Oi5nEYEkioBNLTn10SumVVHTYKUYYnJkt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8NzlhX7; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8NzlhX7"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so6411a12.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 18:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785460005; cv=none;
        d=google.com; s=arc-20260327;
        b=boSWj7jp+if/vZJM2dC/d/Yxv381yUQMRVazNTqWbPQ9aaJwjqegS7BPwGQ5/19iVe
         C8ysuu1YS/2e9COSXmYI78xzephzB32wdKCEis7vDS9ADDvw4MTwYVTMwnEix1J9y+j3
         tXeG+EwRuvrfIiNUpk2/14tPrc+WTDsIEZ1zO9ZkNg9bDsQ7wEYvavsu7gmohBBnelv+
         ndYu5nu3hOrCRyfYLjSzM/307MN4+d7IWP4O87vjB6g6ubH8ittiuC4HOaqXNZgOwoYf
         xtxzLVq4RIRVRCTJVr2JMso71P7pKdnQnI//qD0Ow1hq8cx7DJ/NZcazRxpgq9wwLRau
         2Duw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3aSJo7NI0/BigI7Mtd/Ltf6FSWBj3N6e3vsgJQ9x/yw=;
        fh=8BdnSTId84WHKnbJPDC9emYMZ2yR4onDiZemygXsTgQ=;
        b=FUWEHEIB4BcsBVSpLNHe4HNS+TCKiTOT56O6cgAXdHVUFa9e7HGQhdlIxrh+M0Fy7I
         p060ny3gzHn3VUIsOSw5WRAftKZmN2cXH1T2lcJgaiwGJCyKL5snFY0r+kd04j5eza+7
         4jizy7gLT582r7ytnfQgdQqtAo0LPqJRvMF+DYWBX/EHUb5zBqdNRX6U4Qt5irkWkrbR
         +QG7v3NjedJa5SGj88jbyyporN+oAobcHKy/exkdwpxOWfDZqASs7Rk+TF1n7yYrSJbF
         CNkW85yQr+GP9CREW9tZ6l/j2R2i87PeMpk+Kc1K610ZT9gAn2Q7QIQXGUCmw7OZcp44
         3qGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785460005; x=1786064805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3aSJo7NI0/BigI7Mtd/Ltf6FSWBj3N6e3vsgJQ9x/yw=;
        b=b8NzlhX7wwn0H/hD8CYOYYrrXUuI38Bb6hE75QooNIk86txSfrcGnafIocK8YAyVjJ
         YDhbR7S/baK1HY01J3XWxSLR6W6Pbny/d1JFLztGjSur5jS2okGilAS75EvNLew2E/Mo
         c14sgkMqKTBK3tyTOBLdq+G9S2s9O72B/U7PfzfTmd6oVHpq3oCCAzuckyHVv3ytK2Nm
         /T1sAXyFMyu0K5G77owe5DksMTc8grmB+zOqyXflCYZ/QHPVFfFL1V9rkPIs2joyZCHi
         0vQxR1fNmEplpwcaqxN1ivvTf/9N0Xgwt0kDD+95MIt49Ari7XYuZV1mUkuyvWzdrB19
         tKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785460005; x=1786064805;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aSJo7NI0/BigI7Mtd/Ltf6FSWBj3N6e3vsgJQ9x/yw=;
        b=ebm7D3q2CfnXS0HzPqZXON8isIJzAfTtbMdZb1LPeeU4WHebYdBR+0QU5uvkS8rP7C
         H12e+qfAlRC0Ehl8lxXBLyZvei4E8ym/JdikGqT5VTpCPQxM4Emx20hmXTP4D+agd6VX
         x590nNxvTtJUBmv0bJEeDj24iVLnT7LOKKoDO1N/kzAJZBRKvlU5wyjaP+rynRzshrlx
         HCbhQmp4XM1bgcURqNiwmXkVet5JtP2WKgRDMdDoQC2LUuZ/rN6U0G/BDpwFyy7MU/Zc
         tVFYoR0jo62aTjY/8YZPZQK5PPmui4bcmRTmt4tJpa+jizCBlQCVYv7MTWh5NLB8Kgbp
         MNrw==
X-Forwarded-Encrypted: i=1; AHgh+RrZ4oABYs3GGGRDbSQMkuiZNAzCIvhWFUQk7i9VTHk3Tx07S4to2AZPj8qOu/lKu7u+IZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5WThhVmkRxOtKTC9pFTIKtkmeKV6xgAwOrFEeXQMirsWHBWTb
	stpZoZBJ1UGFNPaa4vpL2DKYBKDFxP5pASlj0PM4OlL9VKBrOjt7FT0L48yvrR+goCmPYKPaOjS
	5cmwOXQaHK6XmRG9XeW0Af+YFKi/jTCIgnmJANB5R
X-Gm-Gg: AR+sD10ZN/M35b8PV1Dcms8s1Fi4t9YsoZ+zA/rmiITkcZHbWvJ/V9SlVGySy73LfpE
	9brfE8P1D/Uy3Jfvfc10tSj+WXPw/9cdaa2n5IZDViGeM1VxNnQ0VfXCynLPA86ULW9dEcP3+/2
	i1EmABigdHQicnAXuigeeCcOPiybSpNxvq5B1XWr2+VMN4i7IdDfEtZQdY6128uO6m1nv+doHPR
	Zx/f/nF+FyCPIxtAc3LP0ls25wC9mgsujMzq5DXxpcBXB2I9smEV3aiFDU88PQV7K4wX2f3r2Bf
	+X1rOjV4E7yqwlaYA4I15svwDYYLd0k/w9z8i691HE1D2rLeCRJx2BDWkFT72aAuK6WSf4YaUOo
	Q5iocJDeHerbxeq6zaeslmydZUGa3des=
X-Received: by 2002:a05:6402:544:b0:69f:2c93:b7cc with SMTP id
 4fb4d7f45d1cf-6a09820dee1mr7011a12.9.1785460004523; Thu, 30 Jul 2026 18:06:44
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722203801.1854941-1-tjmercier@google.com>
 <b8541508-5046-448c-b32d-40c7ad79b1e9@gmail.com> <CABdmKX3Jhrb3G3_25CN+TAG8oSgOqJwr0xi8XUC8c7RsCS=h-A@mail.gmail.com>
 <dc95818f-eb75-4389-be28-b1128126b92c@gmail.com>
In-Reply-To: <dc95818f-eb75-4389-be28-b1128126b92c@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 30 Jul 2026 18:06:32 -0700
X-Gm-Features: AUfX_mz3gZMvntWT2ZXD_0nx7Sf8pZoTmY7GAYqdViyxlEbZ_EdHEHVzO7O3TZQ
Message-ID: <CABdmKX39yhgZU9ATzzjmnvCbNqO1i=2KwuroL3YDsgMN+DVp7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] bpf: htab: Reduce memory use of hash maps
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 7:35=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 7/23/26 6:22 PM, T.J. Mercier wrote:
> > On Thu, Jul 23, 2026 at 7:11=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> On 7/22/26 9:37 PM, T.J. Mercier wrote:
> >>> Memory is expensive and scarce these days. This series reduces the
> >>> memory use of BPF hash maps by eliminating the per-element overheads
> >>> below. This saves up to 50% of per-element memory use for standard an=
d
> >>> PCPU hash maps. The memory use of LRU hash maps is unaffected.
> >>>
> >>
> >> I understand that these savings calculations do not account for the el=
ement
> >> value overhead of per-CPU maps, which make up most of the map memory
> >> consumption. Realistically we won't see any memory savings for per-CPU=
 maps.
> >
> > Yes, I did not look at BPF_MAP_TYPE_PERCPU_ARRAY at all. 95% of the
> > memory used by all of our BPF maps comes from hashmaps affected by
> > these changes. We only have 7 BPF_MAP_TYPE_PERCPU_ARRAY maps and they
> > consume only about 12 KiB. (I know a few of those PCPU arrays are just
> > to avoid 128 / 256 byte BPF stack allocations.)
> >
> >
>
> BTW, did you look into BPF_MAP_TYPE_RHASH? It does not
> yield much memory savings compared to normal hashmap, but performance
> is better in some scenarios.
>
> Link: https://lore.kernel.org/all/20260605-rhash-v7-0-5b8e05f8630d@meta.c=
om/

Thanks, I've started to take a look and asked some other coworkers to as we=
ll.
