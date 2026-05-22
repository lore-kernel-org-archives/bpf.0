Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45425487C
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428466; cv=none; b=AthXFvkZZZohGt5Q3ZC/BMSbebXPd+kU2yi6233UVysO1FHgmmr0oKQ+cx4KO0xMggSCYkvLfhhv97bNce1EO2mu41PON+E1xXaKCFP+wRYOpnbUXVYC7I2RP1ZwvUjIaZb2LWFgprrEcBndrkj40wTTg25/4x/ry7NzJcBWV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428466; c=relaxed/simple;
	bh=7BukE1lYqgUHUUwtz1gAmazYBI49l7hQ/livEgLx44Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5WdMceJFUpMxdy3B+resOmHRNgmnFSB3eG12qQLlmpu1ihDClqhgM6iWXKHiqUaIPioKaMy5YlTThC5odqZLE+WLqUUYCtyyZFWyp1LDPpUygouXddVFTi4L7OFNZLRuN01Ykp7TWVd+yHZ8II+mc8CAD9QKYi29iJoYS3lZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoiqBeF9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoiqBeF9"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-365eecc5885so6371523a91.0
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 22:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779428465; x=1780033265; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LAcpGt9A50v8TVjUmtkbhcVP3i52hTzkHXHZgVlleSQ=;
        b=FoiqBeF9uJreE7bVec7zm9hGOTrUYdNQb0oWv01T1tgibxIBgI+HIUroG9lDU/7y8e
         7A5vrwaeLf8rWbvzzoC378WJjdr/xXxy6w/iL31ct5xWR8S3cqfcXbvXl8AJWPv8id+z
         XQ3TThjeH8HUbGRKw0yGsQdX48OegV7p27N3AKb57BVD0fStr8Tdqiks5Ioe4Xa6mjfZ
         s6NYkUDCaWCoR/DfzZ5T3FN5n/8D+rrRz2ziauHbXhjROXmtCBwNfv4q7A8YKOnZATww
         iMGQ+NuYRlH1SUODVgqYpHX1uhJG1WR8UaVeiYh3e6OKMLaaiw6XiTiBWfkOWJLoZ/K9
         mBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779428465; x=1780033265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAcpGt9A50v8TVjUmtkbhcVP3i52hTzkHXHZgVlleSQ=;
        b=hzKNQQ9Lea4UPrEW3fMEy4/sZU+5afPfeScPLMqM4xzlk7KktuFPtqxiYyvUwSBRKB
         JXba5zLVejSP3P1yXTEoJ7ttyUjw/X862sER73On8cUZBOoU5fm03ZJ4NmDDV2BqRrSg
         f6Bdp0qqYdaRFpSi6u5wsXh6JT+XDwkNAaAdwfHU0jMaGRspfEcSliLmhoX9WrNy1+um
         poyyNdMl0XmRMvzE83fWsDYXMVYlvHky5Wfq6PiuARrJhXOlQssw0fJdUFOwDvCh090c
         lnKWYyKKvdUffSIxQ0ONsu9mi5ha8kiZOyUfBzdFmBmdOF/xIyz/CeoRjguKt5HnKJkp
         ZrZg==
X-Forwarded-Encrypted: i=1; AFNElJ9vEfJpK96EKAtgq2qBdhEojA3BvLE6EXuUe3cFFdpHTkv6M6Y6dKIDC+1HXC1lSHGhcgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6lO3B5CjaJd15W06/fOUgeT9ayjTjsp+e5VD1Q18slpMznQyn
	s3UFe2Av5E3pyaGqWQov2v63RO73SMqZrhw2F/cml2nq1ClImmM2c6Mx
X-Gm-Gg: Acq92OFDgqqjwbVhymfmRP15sBEEFmuCqmaC150mVNA9gDTOQactwmksgaaw7kLG5Zi
	pUtoFKkM+Drtd8upLY3b/UkByah9wAPb1RGIi/PWtLGNjCdCgBlCYo/P4BuJsbBjbL+IA28fFsc
	VXWgcY50ZfTZGpPYa+tcvFAE/W9F9kpUP9W/QR8OHDYQs2piV+SON0zkUmSK0E/uhxjbHepoGew
	RuBEpGB1wtofeCcaTVoxAnT8BCXzQNJJcqFHL0WDIZAEfS5Cj63kOlg+5q3bmgOYXQskUBUGnHI
	rKgawwVcLP7ca/cuAJTKUVSw1flCWqxqQqSBOK2pUz6f4XQQBNpNoVtWvPEXCPpNEgzue4ZwvKg
	gJC1u/imMU/2lEL2wGX8+O+IhS2vmf4dtSr2A9cTeq/8ONf3t9e2kli1zB01mAO0N2GTa33HWMM
	rKDTCAkpZmwFOGue79Dgn00ihXAH6fTTdCO93Uyjue3bc50H01dV+y608+hYYGcxM=
X-Received: by 2002:a17:902:c94a:b0:2bd:9728:5e42 with SMTP id d9443c01a7336-2beb074b967mr22794405ad.31.1779428464695;
        Thu, 21 May 2026 22:41:04 -0700 (PDT)
Received: from [10.188.79.203] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b3085sm3806315ad.53.2026.05.21.22.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 22:41:03 -0700 (PDT)
Message-ID: <ccd74b6e068e0ef02d429f3ede50afbdec516715.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 09/14] bpf: Fold ref_obj_id into id and
 introduce virtual references
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Thu, 21 May 2026 22:40:59 -0700
In-Reply-To: <20260519181314.2731658-10-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
	 <20260519181314.2731658-10-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-19 at 11:13 -0700, Amery Hung wrote:
> Remove ref_obj_id from bpf_reg_state by folding its role into the
> existing id field. Previously, id tracked pointer identity for null
> checking while ref_obj_id tracked the owning reference for lifetime
> management. These are now unified: acquire helpers and kfuncs set id
> to the acquired reference id, and release paths use id directly.
>
> To handle cases where objects share the same lifetime but need distinct
> identities, pointer casting (bpf_sk_fullsock, bpf_tcp_sock) and
> referenced dynptr clones, introduce virtual references. A virtual
> reference is a bpf_reference_state entry with is_virtual=3Dtrue that
> serves as a lifetime anchor. It has no backing register or stack slot
> and exists only in acquired_refs.
>
> For pointer casting, the first cast from a referenced pointer creates a
> virtual reference, converts the source to a non-referenced pointer with
> parent_id pointing to the virtual ref, and gives the cast result its own
> unique id with the same parent_id. Chained casts reuse the same virtual
> ref. Each pointer retains a unique id for independent null checking via
> mark_ptr_or_null_regs, while releasing any of them releases the shared
> virtual ref and invalidates all siblings.
>
> For referenced dynptrs, the constructor creates a virtual reference
> instead of a regular one. All clones share the same parent_id (the
> virtual ref) but get unique ids for independent slice tracking.
> Releasing a referenced dynptr releases the virtual reference, which in
> turn invalidates all clones and their derived slices.
>
> The release_reference() DFS is extended to detect virtual refs whose
> parent is being released and report them as leaked references, matching
> the existing behavior for regular refs encountered during cascading.
>
> Also add reg_is_referenced() which checks if a register is referenced
> either directly (id in the reference table) or indirectly (parent_id
> points to a virtual ref). This replaces all former ref_obj_id checks.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Consider two modifications:
- A different approach for pointer cast helpers handling:
  fork the verifier state at the cast call site:
  - Push a NULL branch for later exploration.
  - Continue with the non-NULL branch: strip PTR_MAYBE_NULL from r0
    and set r0.id =3D source register's id.
  - All cast results share the same id as the original acquired pointer.
    No new reference entries, no parent_id on cast results.
    Because reference_id is shared, release of any of the original or
    cast pointers invalidates all other pointers.
- unmark_stack_slots_dynptr() deciding which reference id to free
  basing on the pointer type:

    release_reference(env, dynptr_type_referenced(reg->dynptr.type)
                           ? reg->parent_id
                           : reg->id);

With these two modifications the following simplifications are possible:
- `is_virtual` flag is no longer necessary.
- `reg_is_referenced()` reduces to `find_reference_state(reg->id) !=3D NULL=
`.
- `acquire_virtual_reference()` merges into `acquire_reference()` with a
  parent_id parameter.
- `cast_from_ref_obj()` is no longer necessary.

See the branch [1] for the complete implementation, with commits on
top of this series (two fixups, two commits for the changes described above=
).
Existing selftests are passing with these changes.

[1] https://github.com/eddyz87/bpf/tree/refobj-id-v5-suggestion

Wdyt?
