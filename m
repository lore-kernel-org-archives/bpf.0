Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9631F4634
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789431612; cv=none; b=UmlvhIcfKvojY1DC+lrMjt5Dc76DrVyWRz8ClNjlqH9QKSWVu7ZBwspRn1BDXBaXqtreW5s8boUzd4x9liVE9NXmVmgS6I+axIa2vPoqBX4UoJWX9eF1lub5dcxjls6fAx9+lw4u01OMqSjSx2OEGIymWYVWoVvOD9LdSNGgOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789431612; c=relaxed/simple;
	bh=DVyF63iH25gJXwTv9c8auzDZ0kdD6ThnlcIhHaZsTnM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ROV+R5BhWik+ASaCoxI0IbsepNBFePvfi2/PkAiRQSEf5JJfz2fwASJM3F2ILxlUoQx4wmDbvqcgPBUGCgKlEzN6pOgc90pMs7c9rIWIrkQUe7u0t3eP7VPbGHyQ3cxB/5BKBFlKe5UFI88ZHPfVJQYdszh22/7dJl3izWWnoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMMu4QKr; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMMu4QKr"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91ede8035so30188525ad.3
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789431611; x=1790036411; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DVyF63iH25gJXwTv9c8auzDZ0kdD6ThnlcIhHaZsTnM=;
        b=cMMu4QKrOvPdQrxOPlsPGVmKhUjdFJM7SKB+uEzb6eb8HXbDdcOitdcOn3qF2zxUm0
         +2aZZR4KyFe8OD19ZYsNsFy7W3ZpPFwogLBrreirSY35jVmhEskXJ6poj0AKgHKcrLMm
         KSozYUaIexvHZ8EMzVFi6MsHc5joGFHe+nH4+pFw8OlY6NABSqNb9V96HN6+fRB42Y1U
         z3I6KfvSgtWzb9mGRREwO/72htdC1rHYzkmeagLrDKe0/3rHbdEvIoWZS+wzGoJQrvtB
         s6Qf6BD0lGi3KzrtP+1D8GWafWr6RiD7Y2q38u2CB71G3pKxxPJRuCCSVDMwSSXCH7sY
         YK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789431611; x=1790036411;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVyF63iH25gJXwTv9c8auzDZ0kdD6ThnlcIhHaZsTnM=;
        b=mihuRc/lhqQtbtAyROeykc3UenHhnd54Yz3+JqyR/PEKWzTEwLRg7c6RLyER75EOs6
         1oshH+tdP9QHoxojSxeXJRyYZdYG1zYPf0YVMnbqM2OyCsdcBH6+JvbG6bIcqnCvfyZ4
         llnotSqyRZAuIaqe7aWqwWJ7ugtOhg1ox/+Qm/AAx6BtzlnHia2foh6Xp3YiB0KQbdBT
         Qxx4diVGda6LYJ6I8zp2xn59uOq53alrhCoPvzStTaQ+KKh5QqWghjPCHLElJoB6FRVG
         cSOjqU/wVsMIdQSaPmKa2r5Mj6Tu2Y0T7ldTAWg0uGTUqRfFthZLNkqf/8lL+QDSi/hm
         MLBw==
X-Forwarded-Encrypted: i=1; AKwUvBwwqUVvSMbeHo0NYQzX/AuSF3QH75/w+EcLJeq3Pv/27ncS4PluW7RrImdI/cTQOnjxceQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kwpXo+30NuXvahaGZHCOvT/EpNOU8YvzDJZgNb4zzQZ9IVEuhz
	ojwNoa2LW9LNPSi7RcxKB96w0bNULA/OasDXHpdWzUpRqi25Fhr9maDAclhyaWOm
X-Gm-Gg: AYBFou2276yzK6/AYZSOXj2B8AEphy6vv7jC0Ev1976aUzrYpVGtFBT1jQonW1X1wVU
	623XRm4WOiShdVuOA8Y+tfpt/GUVIef30dqAiOICOxURdDi+GKfZkuVBzK4cAV9zQWyiWnrC81V
	UgFOaIvlwkMpDYFAMHKCfa4NKHOEdOMA8oxxAPLGSgTbKFeD2dNUD441zfbYYle+3UuLGeCJi8l
	DA9ueIyyIno3HcsXtDSHDwxBvkAeGqTApZ9j9lwsRQ0s8gV4ZLfJeg2zyxW0pxv+ZHvZUV6zfnT
	uj5O8r4RjYT35xTCzL0yANGm/JaSld1xLLnsqO1rP89tlAjK0UBZkCPds5kkenIcNCA/x9oLv5M
	bxy5GJLpAke7+8tGecWAwhJpcYB1Kj75guqQjR5EustFUFYSReHJEAxMP135BQyd3XJNE7hSKvQ
	8tmFnU0WTTNZum0o/B3KR3g8inZs1nmMgOqOmBMSe16CF8zdaPGRMfX65aMiZxML5QF4BN0Q74/
	M8qB0hnstAGwifOsemmsVImIl4xgoRpmkn3mg==
X-Received: by 2002:a17:903:98f:b0:2d8:d4ce:7e40 with SMTP id d9443c01a7336-2dd6c7622e4mr102586575ad.21.1789431610593;
        Mon, 14 Sep 2026 17:20:10 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd4bab2981sm39948235ad.49.2026.09.14.17.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 17:20:10 -0700 (PDT)
Message-ID: <5ecadaeac7399c0a0c19cd5e3d6a16589b4ff9c9.camel@gmail.com>
Subject: Re: [PATCH bpf v2 06/11] bpf: Clear insn array jitted pointers on
 map reuse
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: memxor@gmail.com, a.s.protopopov@gmail.com, info@starlabs.sg, 
	bpf@vger.kernel.org, Sandipan Roy <saroy@redhat.com>, James Burton
	 <jamesburton@meta.com>
Date: Mon, 14 Sep 2026 17:20:06 -0700
In-Reply-To: <20260914170326.249953-7-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
	 <20260914170326.249953-7-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 19:03 +0200, Daniel Borkmann wrote:
> An insn array records, per entry, the xlated offset, the jitted offset an=
d
> a jitted target pointer in ips[]. bpf_insn_array_init() runs when the map
> is bound to a program and resets only xlated_off; the jitted offset and t=
he
> ips[] pointer are left as the previous owner set them. A program can be
> verified and JITed and only then fail to load (e.g. bpf_check_tail_call()=
).
> By that point bpf_prog_update_insn_ptrs() has already filled ips[] with
> pointers into that program's JIT image. Thus, the map is handed back for
> reuse with the stale pointers intact. If the next program reuses the map,
> the stale pointer survived the now active program's jump table, pointing
> into the previous, freed image. Fix by resetting the jitted offset and th=
e
> ips[] pointer alongside the xlated offset.
>=20
> Fixes: b4ce5923e780 ("bpf, x86: add new map type: instructions array")
> Reported-by: Sandipan Roy <saroy@redhat.com>
> Reported-by: James Burton <jamesburton@meta.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
