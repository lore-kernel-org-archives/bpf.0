Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E1480DEC
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494073; cv=pass; b=SUiRO8Bl6H9KaJkjUyqIHZ7qin0lZLWYChOVJUOqAc42hmkRq9s+JK2a/iXwOlM2dXREYcYRRUn/79+YsHlEPUe+Mk/4h82rJ8x8TwS+ZLuDuICyZhS0iQX0BECrHgJiTvWL7wqAMqOD1tgeCcTpycLCyesCt+kHwaLRxiElY+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494073; c=relaxed/simple;
	bh=J7rJ+psstM41lQdClXENMU3RowvbfJZpg/uE0TTPkaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDrhoVXS3nKL+o/Dt8A4winODOVf+m6Z6Nx/WMWBFQURzQNhK6uxAk68j2LhBL92e0wZodHkNB73tZoawdAjkp0jNBNzNS6zPkpSyFoal7TgR4k43QzD+E1RRUwnBZZqxrLAujgV9hhZW4tCt9gD0b/lNzFylSTwows7RHx606c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jykXbYFf; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jykXbYFf"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so14381566b.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 10:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494070; cv=none;
        d=google.com; s=arc-20260327;
        b=DSKplKGor8TxW7NgGPaTQ+RgxzrY9nUhXMlHC/jSW5wUafyLM95qsHLEKBlCh9I13B
         vyayC7hoCCeZlFPRR08XF14ItKgnSiD/49Yq5I/RyMiaS0FDVpEQmIlT5gPxWum4qmdN
         UNhz4kfLR4igUn7VL0Kk4F0qAo3x6gfY/P7ABNMQE1s/urK1WTpvnv6SS/jHTWliu2od
         CSG36ohPSEehy1CDkOidWhoJjqlW40A4o2/07VurUwr9GIdPVmLZcN8jN0qI0zEYqI2s
         bdIYvrSfjCBBXEbI7CjlRu1t5SQmnxWxTyM0BlGUPnduajWyLrRT1Oo8nkhcG5EupqoA
         +nFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J7rJ+psstM41lQdClXENMU3RowvbfJZpg/uE0TTPkaQ=;
        fh=L5a8hW2rJ3TD3RWX+sxaMhP4LGSECOebOywJgBtIaSg=;
        b=NXjjdJNhWg4EDCmfQCjnVgBzflanoCDYri2sWwuF0Wpq6PJ5l6Dr5Debg3UVygCJvY
         dnrioNTE02l7DTbxmjWDPsIPFHBkmqlePCJ+eZOjF+4O/yP2vJX+AM3g/K8RAo3n5jho
         iE5e3xoW7LP2QePfHnVCLkqFA1r0+ODaOoAuuxBcVYy4cbOxzNglbJGoN+cp7H1US4pZ
         to+GE+rYkMwVlha2zNAtQciph7sQ7MAbG6ALpwTdBeyXWc0iecd0oKEQ8XbMzCWIGFry
         XQoz3Hht2MQbM0ih4rOQyF6NBh71adWWjBGiXoNXVKX1x58maM5ilqYBALv03e2kfK2H
         nv0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789494070; x=1790098870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J7rJ+psstM41lQdClXENMU3RowvbfJZpg/uE0TTPkaQ=;
        b=jykXbYFfDZkP1rCTvjVbTHa9sV83bkSCZJTB8qn6C0XoCgORmXv+GQ1jqUIiLD9D1J
         3BiG6+Xg8/FLKVEmAufIqYeOx/l9hjddgb9VqSTqWXV1328LKj1lU9+5YU52ADG77vtr
         +9EA7jZMNuvEkEVDISJtbpohMznkYQ66p2DUs7e3JTsOZTh0M/cBrKmqCp7vd9ZRZIdP
         EYfuyoop6JhkY4qNuituzBlm2B3yb9dfFh1wblyEtl8HEfOhu+rU8j3+/NKBc36rSuFA
         6ApzVz6pACRmmHUf2MBekoyKZbWOLyt4sWxCobttnnB2rLeB61n/UJRMPFdl9P3UcBSt
         u2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494070; x=1790098870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7rJ+psstM41lQdClXENMU3RowvbfJZpg/uE0TTPkaQ=;
        b=loKzC+0yFV1dqfxozXg8Mv3Zr91N/GB8peLMmxKwzOtyefWZjMMU6YUenhzszYMnnN
         rcBBT5Y31Ws3I36FuosWwbGrM3zb1Bx/D1uhjD1e1E7GOuirls1RItsW2fYNF6q4933U
         kzt9uAMtqVcly0Bm4cKdqQb7N51Bx+K6RRJYqk5mHMqRP1xyDX3ga3kMA7laRzbC8xyB
         Ew2bd2v82cBITJm9dkqWeYI4RRYEHlNsSia4vfgKuNSZrC0Z2/GI6dcdA4uFWZrvMe9Y
         jMilZ7pUOdaGNKph5udbzRwYcTtZ44+iy9u9VmpwdcraTtxVkwxVshle7V+1g0UUQqS1
         XWTQ==
X-Gm-Message-State: AFuF++ml6gLbv8zdmLw2C7EdtBvuwQ5wbXlYfPPTYoRKvnR4t1GuJ1ba
	fKUGzTd3GPXzM/cobAyLjCGVWT5QFaMoj/alMJiYM8oW53Vm4Wp+0B/9Dx2RynVaMaWNxtv2HAE
	ub8fujjd1GBtiepptFnTbm+ai74tBEU4=
X-Gm-Gg: AYBFou0IXdJjrlEfdTeWHzImA9ePzDyTNV3YwKKEtK6z0SXbgUgb57oOMNCsccRUOWq
	qN1pOuzA9yd4x3hi+qOH5NQx981QJ405n3rvxmf5or3n8SLNamV0NekNdxOM9kmD+CSxpCIjYus
	+fRHZysbrlBTiQV35DKFCkcYYXeOyipOmH+jfHlvB+w/sSvvWWd/5GJQ0Y85fifRsCP14fqcObS
	TkegCWon477xfcfxmOBbDpt8ad7tHfXdBLFfVjuDv2ssocwCtPTYUcX8kFUYsT6NeI7Liq5gLTU
	rgJ7d/HIKaHHLb9f67PR655oolAMt6D91Nss4uGOVIEc/S6aTMduag1BFglSotIMvZZhw2X8
X-Received: by 2002:a17:906:9fce:b0:c21:180c:d82d with SMTP id
 a640c23a62f3a-c29d77d91b0mr168856066b.20.1789494070013; Tue, 15 Sep 2026
 10:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915162252.473044-1-caomingpei@gmail.com> <20260915162252.473044-2-caomingpei@gmail.com>
In-Reply-To: <20260915162252.473044-2-caomingpei@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 15 Sep 2026 10:40:54 -0700
X-Gm-Features: AcwNN1UyciYgoXk0x8vpg9Tw4ESsAPMDRBS4vPpVrUds5eKGHTjnzQMu9WuIELY
Message-ID: <CAMB2axN=ZEcJTJPjwXe-nW4Au5Nq_w25rOjEZSCatFAXW22JsQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] libbpf: Reject local struct_ops bitfields
 before data access
To: Mingpei CAO <caomingpei@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:23=E2=80=AFAM Mingpei CAO <caomingpei@gmail.com> =
wrote:
>
> A local struct_ops type can contain a bitfield absent from the
> corresponding kernel BTF type. bpf_map__init_kern_struct_ops() checks
> whether data for an absent local member is zero.
>
> For a bitfield, member->offset contains the bit offset and field width.
> bpf_map__init_kern_struct_ops() used the encoded value to calculate the
> member data pointer before rejecting the bitfield. The zero-data check
> could therefore read outside st_ops->data and crash libbpf.
>
> Reject local bitfields before calculating the member data pointer. Keep
> the existing rejection for bitfields in the kernel type.
>
> Fixes: c911fc61a7ce ("libbpf: Skip zeroed or null fields if not found in =
the kernel type.")
> Assisted-by: LLM
> Signed-off-by: Mingpei CAO <caomingpei@gmail.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
