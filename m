Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3D1292F3
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813027; cv=none; b=nW+ajKhKB7jnKdCLWH7kN/cEATAaEDO6QJMAGbWWk5A0AKZyRyx6f4bjQv9QBxbTVr8r+PJzjqCDr/IZ408U4qssjIuMRqe/G84OKhv4VTd6T07To2o/R0NoQdWaeI3DiYDvoe2oeH5HQe4lR4ox56uP/bwMooISEmhJnJf6y5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813027; c=relaxed/simple;
	bh=FL+4o6Mqp2qY6AlA9uci3R2x9eyxBO+s9okMxNBiuwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQpU+Js+sE5LxQ7O3xFdCLa2DLrAbk/lm7IbiUDtXXOpMbZgXkgvHB/bhMKtLd2A06KHpNv0KsqmYg0ebKHTWzXBvaGp/35skHgCemAeRXZwRVsHAL6h0fIlM09Qq35kdnLdlyiO+dTPL0Qfa5tNHWEXWAOt2Y19+wAe8fTzDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NP8qK/xV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NP8qK/xV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709813025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3+jl+6QmBqCt5DlftyUQTEGEi2pwkpy4lDaj29hm/Y=;
	b=NP8qK/xVVqXT8mxFHxPMn4IlGLhS4ylck6qI569Y4Sc+Wa5qSpX9oCv3m0Ng5j4bEE6MHk
	A2SKFrILAXV8lvTaAeIhxJOaBlaz8wd7ujBwePuE+sXAc6S8hn+b39H/QW4Gv4EhToI6wn
	R5+jCHTFPJTey6yyuHzl1u/DEXQjplE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-NVSrBOd5OXeExk6CZR8B_A-1; Thu, 07 Mar 2024 07:03:44 -0500
X-MC-Unique: NVSrBOd5OXeExk6CZR8B_A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a450c660cdeso51827266b.3
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 04:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813023; x=1710417823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3+jl+6QmBqCt5DlftyUQTEGEi2pwkpy4lDaj29hm/Y=;
        b=faXRJFYuDeN3uI92y0FEUX5mr9H4NMFMLmTFMUqrBpc3aonddMDyAhJsqRCrvurWbx
         zsX+ZCxPRCJeC+j6tBwPZlW8/KxWin6VnNe+TLkEmLMEVZ3hHpl5IUFAE16aa9Nk+aWJ
         i+KYMjBLXozFRHHh80Hf5B2fwS0FoOhJssFxAA02dDh+R6UDMrmgTbF5seLnsOAMnD+/
         Cojrrj2QX7UNN0KTnaiWtdX+uvXrbNtVRlXX2XPhowzXGIwLrvsJr+P/HBQAXIFpgJD7
         NMJcDC1eEbB7dENGUa36CexP20r38eJtRuuxDD8KQiXva2p1JEEy3w7EANhXBFjN0b/L
         P8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTzhHC/WZkpjNvYNe191tLuVZXSFYwi5n2kvmfcGJYaEyX1yxwds4Va7SAGTlV0Tb7oscWznAAFg0p+e3CEGCpSLQj
X-Gm-Message-State: AOJu0Yx4ed2HE7cYxF0My7bscfJfdCteyq3JlQg8LFQwlewl2g0bNfRY
	ppqfXSnv2j0Y2UIcCIvU74D1zNfOIz2fw+AFEXbxLlA48ebuLpBZi85Gnl14Rgo7QBpNJigqK/c
	fX0hUr8ecvmTFSCHlb7bv3Dm71w0poeExye9K84yYVGEiP90iRg==
X-Received: by 2002:a17:906:2310:b0:a45:cd64:9304 with SMTP id l16-20020a170906231000b00a45cd649304mr1084838eja.4.1709813022914;
        Thu, 07 Mar 2024 04:03:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzxRMul53QJvzCt1FpjOjkAy9Db9mMqNTEKAFGHG8AoARu9Ljo7wQaDTa5HmnRj36WTcC6Kw==
X-Received: by 2002:a17:906:2310:b0:a45:cd64:9304 with SMTP id l16-20020a170906231000b00a45cd649304mr1084819eja.4.1709813022503;
        Thu, 07 Mar 2024 04:03:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709062e8700b00a4558314ea0sm4349645eji.15.2024.03.07.04.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:03:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BED99112F37A; Thu,  7 Mar 2024 13:03:41 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf v3 2/3] bpf: Fix hashtab overflow check on 32-bit arches
Date: Thu,  7 Mar 2024 13:03:36 +0100
Message-ID: <20240307120340.99577-3-toke@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307120340.99577-1-toke@redhat.com>
References: <20240307120340.99577-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hashtab code relies on roundup_pow_of_two() to compute the number of
hash buckets, and contains an overflow check by checking if the
resulting value is 0. However, on 32-bit arches, the roundup code itself
can overflow by doing a 32-bit left-shift of an unsigned long value,
which is undefined behaviour, so it is not guaranteed to truncate
neatly. This was triggered by syzbot on the DEVMAP_HASH type, which
contains the same check, copied from the hashtab code. So apply the same
fix to hashtab, by moving the overflow check to before the roundup.

Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing overflow and zero size checks")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/hashtab.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 03a6a2500b6a..0cac6a65235c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -499,7 +499,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 							  num_possible_cpus());
 	}
 
-	/* hash table size must be power of 2 */
+	/* hash table size must be power of 2; roundup_pow_of_two() can overflow
+	 * into UB on 32-bit arches, so check that first
+	 */
+	err = -E2BIG;
+	if (htab->map.max_entries > 1UL << 31)
+		goto free_htab;
+
 	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
 
 	htab->elem_size = sizeof(struct htab_elem) +
@@ -509,10 +515,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	else
 		htab->elem_size += round_up(htab->map.value_size, 8);
 
-	err = -E2BIG;
-	/* prevent zero size kmalloc and check for u32 overflow */
-	if (htab->n_buckets == 0 ||
-	    htab->n_buckets > U32_MAX / sizeof(struct bucket))
+	/* prevent zero size kmalloc */
+	if (htab->n_buckets > U32_MAX / sizeof(struct bucket))
 		goto free_htab;
 
 	err = bpf_map_init_elem_count(&htab->map);
-- 
2.43.2

