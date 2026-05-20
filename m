Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9EF3644CB
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247834; cv=pass; b=a7E1KxAIwAvhq+64mNQsPRfop5ok/GTQ0VWQ3OYO4USFB5MbXB2LTQ3aQt6I0NgDHoYsQUaQ9cL0qRFsvpSyjVgPER7230GfyJD77+osPXGB340GZG8y3D7vgS9ifK7z5/mOjyK82u/a/QqYvrWSmODMhrN6NqmdQ3XeCdlxhHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247834; c=relaxed/simple;
	bh=XlvntvFLAZ/gmagOYtupDAd9TDvKhbdbJAmnyBBol4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMtTacMQEPTk1fegyR8b/ixk+u56lZ+iBEnnlna+62r5tbzkv3wXOA8R44s1nZ2ijE/672fGQuImPu4AzPQRquwqaBJcUtrxMBVE7UYXY9kCmSKHM3BpAQBaRDsptK+NNKS81VH5eidVQe2/liTIHU7yqrRpOnly5HBQV/UWBvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eaqu5VLo; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eaqu5VLo"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bd6460b0d11so792311866b.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779247831; cv=none;
        d=google.com; s=arc-20240605;
        b=LsmKwC3XV8LJmkuwyLm1QkUTptcS85385wA1af/44xnm+qpeFxQhz/FKXT5/saIHQ2
         LcRVqW+QC3YD7FonGukBrdZHXuNDOa3kPQX19t1iQd5AnwjLhuaYooX2A0TYyIWf6rkM
         +NduGE7JMP7Busm+MN2rG2M4smPlxy4H64F+Ta4DME9ZnKC7oqiorr1X77hbEr7OztEm
         2Z2oUbNH5Mbpf5WC19DqDgamcNBxoKHftvx2Fd5vW5p5R0dhwwkIB1++Ys9cCxBXUxCg
         C5XUk2KpxZ1pkDnXw7CfzCOiMZoDEwE2103gtSmwevQ4A/5ATk8xDpO1FA6yj4BtrGVs
         NUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8SIgBJvxx3sBqW2VIs6dSHbO8RZ+0pmRwfw/q7lB8zU=;
        fh=Scv5+0ms326y9gtA0VvDux8q4S5eofpDkLOUfVUddno=;
        b=EqBGoDIqS6mV1VBtB2OOxfSsLtK+XFtJExbx8x7lTG1H172MRkDusCJu5Sb5Il1ETv
         ffYEMIZoS+AoBszrGYc9/l8DkC0EsFpoT/YW4b2reG5ACXMwzpTIu6IuP1sRWI9qvVap
         GXit5RA+ynsRpdTSYFqWmf22PlCgKjDi8F1xzL2CG8CD5YKjlsQaSLgFz4C0hceerZ2b
         4Xo0id0Xgc+9sARsKvRep2idZXbuWvk79tnoQJT3BDNuhuDdsUG+3OXxJuVV/1hLNjNr
         1CDJrX8JGF90kQDX2uVKwpdw6KUiHi6D2hbRBvoBSOj4Uq/ztjqL5hSWkS2RcPoNm7yl
         hHsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779247831; x=1779852631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SIgBJvxx3sBqW2VIs6dSHbO8RZ+0pmRwfw/q7lB8zU=;
        b=Eaqu5VLo/DDm7j35xJKYKs26y1mCyaGKJHTJULRIsAgjJkjAmZ6x5QOSEOZsXpV7Pd
         y/bndF8ofkIl9h2g+JhZ2Fb5XApxErC4croacSpdvu36op4/TE8KrMKbvTcH3C1RwS2B
         RkMFT6U0cQpIKBc4kuzOqvwEt3IaudAx71hVBNj7FHvK/ZP3mPmBoW+l4LcQJ6sHXzjS
         8PGMEGK/2ZiNZKWDfnEcMgX+UOC3e5wDBCoG9lmBe0vS6+DfHI6Cb12c3Y+uSSg9pW0A
         A9P/t+vReoM9YB4CgIA7Abyqv/qRHxHj4IyshDQhQNcLEgLLbVDtgMCDeOTqD2wXZcNY
         OGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779247831; x=1779852631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8SIgBJvxx3sBqW2VIs6dSHbO8RZ+0pmRwfw/q7lB8zU=;
        b=nt8Ycjk7TH3FJIHmUr3f/G29AoQxxJh0CI/rI/UhE1F5usNKiwGhUv7xWVTu22mWf6
         fUyjy9Lx3/XzdrwSTmBWbC3k4U65wp2W6n4zCE+YKiIg8Sb5qxTSigfwlJzSWuCKRKxP
         MRTXCebW0A/Qnvv+L4yPKoEpBM4ltma/hjExKaGKgHmigRWGPujl/pMNJOVCGfqfqx4x
         Az9ti4BRVUBPnl7oLxFU5yZc9gb/hcEJMdK1Jqx9e4pBUN8svK7HBoGt2rnLT37yeMM5
         Ryf3su4towUhGFMhiLjPvcgaI+Z66KMN83SGU52bQ3Uf69U3O5Dz9sIDaSntD6u6Rj+9
         PlwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0Gq99wbAKIhkWCAO7dv9egNzoZN/iYFE7/AWfOtMyLuHDWNYzAcKmy/NECxI3EWXYOH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4tGFIZfMCBRMorZGz77mlok112nTQ/3dV2PaNKyQAHaX3pnl
	l6XbBa1CPOLrnFhDc1mTlPU2qz1bA7dHpSE7DFmcMFtv7RevJakjlCpteCaTgEJiDqqvvbZtaoh
	A9fSmXhRpWoMn0KSOrJlqBpSZnR41fOM=
X-Gm-Gg: Acq92OFJbdleaxevTafIu0spWOgXf9pRCE5H5Y63Q8TFg8t8n8kT+tnNZkHkN0LLpsV
	kkuJHZWmqHcJLyUt+O/0lqkWQ1KlAHQVZc64Z4foKKi94WrGyu0SnAyfNrEbqPhv/dV1D7042HS
	/MhsLq31RW2+2OIqlqVkW74Pxdvho1gQv6kJ5j9mPQ8U24yLN5lNBEnCvxWalQmNjNgXBvFErXr
	UqLb8BgkSLyEqGH4lFNJ3L5aNFK/ZOxqMMyT1dGznRDGsgIAH+nIC8w/EyOfG19g8zSrLjP2sbP
	KOzZOw4=
X-Received: by 2002:a17:906:6185:b0:bd4:f440:ba71 with SMTP id
 a640c23a62f3a-bd5177dd06dmr1203142766b.19.1779247830925; Tue, 19 May 2026
 20:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517121626.406516-1-rollkingzzc@gmail.com> <206188f9-5642-4348-9fa1-c48f9a890640@linux.dev>
In-Reply-To: <206188f9-5642-4348-9fa1-c48f9a890640@linux.dev>
From: Han Guidong <2045gemini@gmail.com>
Date: Wed, 20 May 2026 11:29:54 +0800
X-Gm-Features: AVHnY4IG0C9s7OF73ggcyerk0wqu3oyQgPB5odeWhoxjVWfBwC-fa9GPTMKRXFc
Message-ID: <CAOPYjvYLf=VPTdm4EzmCQ4a6F8QeVO7JT+2YTH1XXD+9N2Uh3g@mail.gmail.com>
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Zhang Cen <rollkingzzc@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 11:13=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
>
> On 5/17/26 8:16 PM, Zhang Cen wrote:
> > SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
> > with this bit set are copied before data/data_end are exposed to SK_MSG
> > BPF programs for direct packet access.
> >
> > bpf_msg_pull_data(), bpf_msg_push_data() and bpf_msg_pop_data() rewrite
> > the sk_msg scatterlist ring by collapsing, splitting and shifting
> > entries. These operations move msg->sg.data[] entries, but the parallel
> > copy bitmap can be left behind or stale in slots that no longer contain
> > the original entry. A copied entry can therefore later occupy a slot wh=
ose
> > copy bit is clear and be exposed as directly writable packet data.
> >
> > Keep msg->sg.copy synchronized with scatterlist entry moves, preserve t=
he
> > copy bit when an entry is split, clear it when a helper replaces an ent=
ry
> > with a private page, and clear every slot vacated by pull-data
> > compaction.
> >
> > Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
> > Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> > Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Han Guidong <2045gemini@gmail.com>
> > Signed-off-by: Han Guidong <2045gemini@gmail.com>
> > Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
> > ---
> > v2:
> > Sashiko-bot pointed out that bpf_msg_pull_data() could leave stale copy
> > bits on collapsed tail entries.
> >
> > Clear msg->sg.copy for every entry consumed by bpf_msg_pull_data()
> > before compacting the scatterlist ring.
> >
> > While researching recent page cache bugs, we discovered this bug.
> > We confirmed it allows overwriting the page cache of read-only files
> > via splice(). We haven't attempted to write an exploit, but the
> > corruption primitive is verified. PoC available upon request.
> > Recommend fixing ASAP.
>
> I think only "splice() + KTLS + sockmap" is vulnerable, right ?
>
> I digded a lot but didn't find any other combo.
>
> Actually the normal TCP/UDP  with splice() will not go through sockmap
> (unsupported yet)

Hi Jiayuan,

Thanks for digging into this. Yes, our PoC exactly relies on the
splice() + KTLS + sockmap combo.

We haven't exhaustively audited all other potential paths, so we can't
say for sure if it's the absolutely only vulnerable combination, but
it is indeed the one we used and verified.

Thanks.
