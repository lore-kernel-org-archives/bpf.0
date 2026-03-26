Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1EF1DE3DB
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528667; cv=pass; b=YKjs2toQtFJ5RxWJQYFW1eI/T51ze9LMvD4ZqtvVH4ILur/VOHeC5F9uUDxvngPi/o24b/5FCFPo6VLA+7LO+XrUz8mgKedGZRnKQZ9cdm8jsAVQixdzk55Fs4Z6t3QZGIu5+OgLvSJUwg4WCNNvh9ZLYyPEOCXKSw45dpp+K8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528667; c=relaxed/simple;
	bh=4vfIHSls0hR9eJFrl8KKddOChPa9goU36LlWQUL4eAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAx6rVKWUSBhKdmtjV2tkWU83boq8FIhRejFrqNyTJn70Ra8cd7Zkn1CqKZU/4VzKg8Kq1QN11CVJ4ZejWr4TB7wb2QUAs8UZzu4XqQOtUfmInMXBHaU/TRw9PDy+sT2dFM0Qaza4B1amH2CCE4xua71f/9oqHdqjCBH3es4hro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1NIloXO; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1NIloXO"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66a82351490so1596588a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 05:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528664; cv=none;
        d=google.com; s=arc-20240605;
        b=eA82NWNexLbwaUqvbsNgFmpMAhzwI6jieS7xDnrD3x3QY4DpYP9/2avVFsrKLoNpDA
         wPSQFCBXsgeZbRvTRb2YDUJaHmDlMIkI0i+Db5sFE52HzrbYfOIFNtjaw+zKOPtEZFaN
         VYPhWtqUS9dNccNkJYCUWI9c1EPa3wQQ5ClMoVIR87YyPTEh+4eAHx5Km9JHT/hmWC/h
         K0DWazYBgEgi3lemnAHHkV7mQagCuRGs3PGl1+bZfZpu6aBIVRcRr4wo+AaCFbu6iEfa
         GPLPsRjxCfTG1f11wizh4O+4M6ryRE0OrFiq4CxGZJQ5+BctOWfy83hfL+sBW+EzAvv0
         PcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M8FW8TOG/ggI/iYIAOkVhhdCPCiS3Oq8BCMwRl36bPo=;
        fh=E1tmykeU8sS5818x6ycnLhEA7UhBOY81oFbFLNKgD7Q=;
        b=YexiMDdhYAxzK98mGEBf6iOwcUU3aBlLAw0N2NlYNFrcS/0MTzf3Lz6Br+yQqizbC5
         DPvpj/MvLjEIcCx3+XEYzKiigfRIqx8QOSHK4tR1luG6uOrQLZLm9+tg/yb61fqAp37b
         U8S/2wo4KkFy/TMND7hZ/LDDmYEvDVvymp2h0duU6dAGRhqQkW25DjsD66DORvKzuIEv
         I6CdXxT5sR938UobOj9ewgc27jzmr2PsB9tI6rL1qvDOfxkthXJYcTLqJ5qfIBQh/3Ih
         lSK37hH4hgX4iZW9PCNQb0T2CO8MThC/rhY/xe0TTF+G3cCMH4gT11ogrCMNRTFhnzn6
         Wpaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774528664; x=1775133464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8FW8TOG/ggI/iYIAOkVhhdCPCiS3Oq8BCMwRl36bPo=;
        b=X1NIloXORKETGrxPmCFE+3aMERPinXXbp7LfSU52GMD+L2zQtl7a7NQ6COFFP59qjn
         pAUT4tfy7/7Ab8RZsNQL3j1WFG2ybtLWshWW6TpsOS3tq+oT2r+9dEX9QUIBl0DYI6GW
         aCLkZshySntQqWMRrDSRn/m9WKbRxTsoJVtPQLX8EIFAqNf4ktNfvbfT6qU6+0JyokRX
         ojZq+s0ZTwlyC/DeGLHACROLlYsIXb5wrxDhbOYza9wXFUBUFLkJ2sikPMiSAghG0zyP
         RCPIR1wuTdDJ+oOdRQ3P9m/OTF/zgmwp1VAiyYwFERjyO9b2HOuTRhfdUHEglX3DQSmQ
         p/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528664; x=1775133464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8FW8TOG/ggI/iYIAOkVhhdCPCiS3Oq8BCMwRl36bPo=;
        b=jYN/unqjCsvddCMCxpy3jH62Z8sNmlnjADDpxEem6phFmhVJdlCV8Tbxr7IwqFUBe9
         +efVAnmCFa+V1yiq7nlOXEZ63mLszijj7VRHIhaRhpq4AOYtPYAN98pQC5hMVynNtz//
         9bjt8udScQI6tc2eWo0fb9R0ersK0HVS/c55p4NnC+S5l9sYt1pNH5kWPn6ZoNBNuuU6
         tM+wSK0vp0CD0bHs5/b6dExuJYjQJi33r24/yLGWNhL019IIaD1TIXUr2Q/4zTYbmVXU
         HPMDPlnd9EX/nMEBy5lAmjksMaUKVgkpRwDlCT7AQZ4Fwbv0SPReV/PmcLXFQUbIXFfu
         bS4w==
X-Forwarded-Encrypted: i=1; AJvYcCWX34wdu+0cmEfzO/8kcliMo6bINHl0xD6L5UAn25sIuuH8jV/NrBJj4jeJIMrjAdsqckM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypEF/eGGG230y3YP+mY87T31XeBRcLjqk0TMqZbUrY9Powh6kP
	7mYaYtZI5ONlfTn0iMtcJAVQiwx1Rn3D5KxlJEH7bZnRPFzGGJEDv8Jgp7kjzdz66vH6NH/UaN1
	ZbMNiEAIZmSOODCUBDniWuUvNwMd8KRA=
X-Gm-Gg: ATEYQzwyv5y8OkRfsterYdrxpTOpWlnTCjEZV8vl3tSFuq5KYwZi/LRXdn3CD4Mq/td
	lnhM48240UMMFCt5HmTiDIQuhi2Hx1wfrlBBxT5DBtZ2MpMWxzLycpibBUZQFod01N7aTifINFA
	09s7tR6e2KVoTo0ea/Xe64txbDxQMXlUlSq9nNyj1hduIb2ZgaVhFOvfqNlWidsBW+aH0q3XNU+
	c0AdmWBpyemKb+Ju4gzp1IzMXpC+k+z95WjXZPJqzkNmUYQ/Wz1xGtZyG3Q77DWY6sUCmvThFjI
	Jc3ukXBu6RNqYTI0kQ/AE3FcCRpmCYwXbTquIC/q
X-Received: by 2002:a05:6402:52cf:b0:667:90c1:844 with SMTP id
 4fb4d7f45d1cf-66b07ee03ffmr1012084a12.10.1774528663980; Thu, 26 Mar 2026
 05:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka> <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
In-Reply-To: <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 26 Mar 2026 20:37:06 +0800
X-Gm-Features: AQROBzDDhAwWy50_0AvWQXh7pN5XimsTxdhJS695rjfTsFhXBLoLPjM3epTli8o
Message-ID: <CAMgjq7B_twv3xhd5VmMJxngAknf9YaLAiwGYpdi6H2n1cXD3-A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim (reclaim_ext)
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, lsf-pc@lists.linux-foundation.org, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Gregory Price <gourry@gourry.net>, Barry Song <21cnbao@gmail.com>, 
	David Stevens <stevensd@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	David Rientjes <rientjes@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	wangzicheng <wangzicheng@honor.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Suren Baghdasaryan <surenb@google.com>, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 4:02=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> On Thu, Mar 26, 2026 at 08:03:34AM +0100, Michal Hocko wrote:
> > On Wed 25-03-26 19:05:47, Andrew Morton wrote:
> > > On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
> > >
> > > > We should unify both algorithms into a single code path.
> > >
> > > I'm here to ask the questions which others fear will sound dumb.
> >
> > Not dumb at all and recently discussed here https://lore.kernel.org/all=
/CAMgjq7AkYOtUL2HuZjBu5dJw=3DRTL7W2L1+zVv=3DSCOyHKYwc3AA@mail.gmail.com/T/#=
u
> >
> > > Is it indeed the plan to maintain both implementations?  I thought th=
e
> > > long-term ambition was to knock MGLRU into shape and to drop the lega=
cy LRU?
> >
> > Yes, but MGLRU is not there yet and with development pace last year or
> > so we are not much closer than at the time MGLRU has been merged
> > unfortunatelly.
>
> I'm quite concerned about maintainership, as it seems the MGLRU maintaine=
rs have
> not been all that active, and the MGLRU to me at least is currently a bla=
ck box.
>
> I'm not the only one who's raised this (see [0]).
>
> That'd very much have to be resolved and the community reassured that MGL=
RU is
> _actively_ maintained before we could even contemplate it replacing the
> 'classic' reclaim approach IMO.
>
> I hope that Kairu, Barry, Zicheng and others who are interested int it re=
solve
> this, however!

Hi everyone,

Right, I think we are starting to make good progress on improving
MGLRU recently. For the last few years we already have some commits
stashed downstream to enable that on our fleet, most of my effort in
upstream is spent on other parts like SWAP, really looking forward to
making MGLRU better upstreamly.

Yesterday I was still discussing with CachyOS folks about their usage
while working on that series for MGLRU cleanup and dirty flush
optimization, and got some nice feedback later from their chat server
that MGLRU's TTL resolved their thrashing issue very well. With
classic LRU they needed a le9 patch downtreamly.

For many other typical workloads under stress, MGLRU performs
significantly better too (e.g. database, build kernel could be more
than twice as fast), it would be a huge loss to leave it unmaintained.

Barry also provided some really helpful ideas about MGLRU like
readahead handling. We are also seeing other vendors and people
contributing to MGLRU like Leno and Baolin recently. Things are
looking promising.
