Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2B378D7D
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787793285; cv=none; b=YbXG4z7gEHEiQ8yKKuwlk1X5xz+rs0CGqVZZfJ2n7J9UGAhoKahSYwFbXLb/uFvD8+YmyDxl7C9mgmAZzSc1MK/2CbJzj+OBA1836rD+cY4UZL1QrbTcjw7ddja333aE+FS/hAZiDwxjnrynQqZI32iFM+lpSw13t3rKHOvxMzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787793285; c=relaxed/simple;
	bh=NBuM7Z8qJAkYuoJEbItk8rVmqNQCo+qHFYrg0x2wOxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5b2GimV9FsHoGcB/dEKtdpBxHDg7ALHahMcg19VbauvtPqC53ELCFBHYL1luYoCVJp/beDaVWwFAiAYp2/cbBTK6LYvZbD7O/3vSodvVAuVgp9A9rSWbvyJD+rZZz/wL5nMXJzMk8aMkujuLcz7Is2wB81azkC0p87EwgZ0laU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3AgovGt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3AgovGt"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-39686abd426so1334867a91.1
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787793283; x=1788398083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBuM7Z8qJAkYuoJEbItk8rVmqNQCo+qHFYrg0x2wOxk=;
        b=N3AgovGtE9a0FM6k1D9Z0Mqy5BbLhs7cDn9YJaPp/kCN9grQdyxmRfBPsYHnxUSMEw
         LmKE62+YO0t4Nl1MPDeFUVWXF0W2K7frcGLGQqij9ELdNmkpTpD+KdCnjgBFJkmRx6L+
         I93lOezFDNFa8TEHtfJ95tLFCom9TPZoXCbBDvvCHtGf/Et0o7hJbXSILwLWmjHgUwKy
         RXGFj74ahisT41Vr0iehUg1Fslrw9Hd5f9CZjb0cdkasbPOKvWs0TpYPdvPG/ycKiMRg
         SMJj2a+FLtvjUwBCXeiNe6d8gJCihOrr0tBlCSe/bZhks9GAvTdekaqNok8MtQmfrCTG
         ctCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787793283; x=1788398083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBuM7Z8qJAkYuoJEbItk8rVmqNQCo+qHFYrg0x2wOxk=;
        b=aXlP2Xyqso9ChlfC+0+A9rY7AE7x/xVbCu4TuKoWi3KdIavweGvE3pkyoRZEqnT7hI
         GOfSFQorJR21nzLh48IOIoegcHm3tJOkg7XOUeFlRJxh0ehM6vJTn25ef7arDn5jjgoK
         OisNxB6G4A6lmrbg/ipk/y9OcGMtjEM0nNGh5eWEAYAdi7kKrA2bbTAjCqUbaahXMvRu
         9wca0Zdo4hXkaDzeTBnrrMDdUWVi5OTUTEypbsVaNRqYACERhU7/lpkIRGducQ7tnX55
         8zaBH5lxVFuKTKkr+NqkAj7k11ffD8mK3+S6jiHuJRwM+1TyrQiGvgFoBSCqYHs3d8Em
         8fdg==
X-Forwarded-Encrypted: i=1; AHgh+RprKaVZ+y8pKJgz5QUoBJYKvSYIFThtaZKXvep5DINeAKtIAOVZ3llW/keYcyB1jRRc0kQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nlr2Gp2t/l1rS/o4XQoYtV2vG+CiHSvpcrfccYlsAfFBNrys5f
	AoE+EWATXpF74/qDEOwQ9daTBBj90IfY1vldpa0OuD9XNIjxquwwc+Vi
X-Gm-Gg: AR+sD10rN7qX06iW+GzI2ejLKL0Zj6QW2IqD0/o7eQOb7r7B8NQQFneDLnCYDyuAEkT
	oeQjxpqLDgS/04NdsBH5H1kJA4S03UPCDuPneoox4Ijxcq3Ijda6CMUZ1bsc7rD0ivzxqi6LeKz
	EZBa0byxd6SrYxORjMYSEYKFgB46FCDldk0GIbO0Z1eZG6aZQofuo1J8VHSwbZN2F6urTfczz6u
	dbKFqfS+qttgUG26xZYD5PMzMDDuGbmWAbnjYhWfw5RVrr6rlDOysYJogz4Z63bpo1LPxFuJBrh
	2ZyQEIPeETsdq2faQmNPp6wSPcdv9If57oEWrm/xbcbae7fyOED9+aRIhsOAbBYNh/sAuioNPpu
	Z7WExmmgfYopIzhc3cKc8AsW7G4MbvrRRoMZjJyvDNlDqK115PKcrSIumQJPtEINuWF8Hp0R9DN
	BAcAufhxntG1VlAydsbfejICR38SZTL3Y+TKLWsrBJReuWFPRl3du2mcHNeHolDwbc33bVNQ7y
X-Received: by 2002:a17:90a:e70f:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-3966d4587b7mr23563979a91.12.1787793283407;
        Wed, 26 Aug 2026 18:14:43 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5c34sm461051a91.8.2026.08.26.18.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 18:14:42 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hagen Paul Pfeifer <hagen@jauu.net>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/secretmem: properly account locked pages
Date: Thu, 27 Aug 2026 10:14:29 +0900
Message-ID: <20260827011429.1516473-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260826-secretmem-accounting-v3-1-94cb04399510@kernel.org>
References: <20260826-secretmem-accounting-v3-1-94cb04399510@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

I tested the exact v3 from this Message-ID on its stated base with an x86_64
KASAN kernel. The supplied selftest passed 5/5 in three boots. My independent
accounting-boundary and capability/delegation suites also passed in three
boots each, with no patch-attributable KASAN report, warning, Oops, or panic.

The independent suites retain the mlock-limit and fd-delegation coverage
removed from the supplied selftest in v3. This tag applies to the v3 fix; I
will treat the planned separate upstream selftest patch independently.

Tested-by: Daehyeon Ko <4ncienth@gmail.com>

Thanks,
Daehyeon
