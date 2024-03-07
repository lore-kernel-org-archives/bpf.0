Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C431129A60
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813032; cv=none; b=avg5MZXJrCKybanc9Z5fKKiLv7mX37JidgKApcc+36Y240L+JG0TnYlenv0I/FnQWaUZcHyq/L4UdySVYWAbM6sMUhgUtWXyGUWVISGRRD+HXB22EW4Fzi/JaEAucBGTJRpW7EeMi13056qTUgPFodXP2X0C4Owrh+dgdvP0lGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813032; c=relaxed/simple;
	bh=ob31fbDIUi4BnR4ztra8TzX+2ZmW6HqiFUjDpv3N4XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsTrh1AbXb90EcHl7zawjxb4ThHszNNaxTdApJVXtiBCcxSWh2lh7CL7Vvy9arlBqzT3zLvD+ERL/U6+4O2Qi6pTzkhbIqW83wFyAdA/4zE+Ij+FMLVligBXM5+Z5Tz6Kr7LXzYcjwB96ix7aOAODX0pp7Ndai+dTt2yewfVHhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0f+QPe6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0f+QPe6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709813028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enr9RLdNx5RYPog0dbXuBVJXCjr0y4Z/JCdIezvy51g=;
	b=Y0f+QPe6BXYWdlZLS/7P8ZBrSqj4QiTzozF81xH1Cpv34sdNvk+p2btA0MEubpNNTdxgws
	luSKPlqUQNIF+fMc3JmOuiVCkb/2bF92nK0KrPSBSu5ZSfmNA42cS8/P9QmEybk+drQboO
	r8QM1/OyIaT0r7thssym/8ZgMYi3gV8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-rVsQNybHMfi-Ss70abVi_g-1; Thu, 07 Mar 2024 07:03:47 -0500
X-MC-Unique: rVsQNybHMfi-Ss70abVi_g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a44d0cb0596so57894966b.2
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 04:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813026; x=1710417826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enr9RLdNx5RYPog0dbXuBVJXCjr0y4Z/JCdIezvy51g=;
        b=j9Zajnru9a9FMNhKkrm4q9Jjaljttt6L72M2kdWNYCNd6P20GOBZc9OUVSLAkVYwso
         GeGo8NS56hnzdtwKdZwI4Y4YeaQVsa2NUXGYgfh0x7dhZnJGNHe8pngpq/F9vHpXjO1k
         t9dfzf0PKYRRtoUPGGJLhFfqCVMyihdZ5fywhb1GG/we05nStS3sJgUl3Cg0z8cvv+Pq
         /N9ARPsHK3GJq6NWYLiRCDyfOPyKHzXTJ+9biSSNuyHHhE18/JwHF6naBdNLRL+QwIId
         ytNA5wIFGS2pTMXHG5rnTeMWGb5GgqTvzGVbf/WWkbvldlCnj70Cf22WrXYvitqFeb79
         aPlg==
X-Forwarded-Encrypted: i=1; AJvYcCWGotH2Stg0zVAuGgFMV+uWtvKt5XJaXCQ/PI9zeGTVnUT/k+Q6o+lk3SePXaJqhXMHMYvJv7iDPkrq35Trrp0sqi4C
X-Gm-Message-State: AOJu0Yzsle1Vv1gp3E6GQYLPuxf6EbliYbiwHcos5cUwaDhYyUi2yd8n
	wMalmaoIuOGil0IoNbwqh8yQfrB2AfAv/X6w1+j7iyVF+Z64SLtjzZTW/G8sLrVFxxhlCZFtP0A
	v8P5/FGFAjTAfP+F7GyOVPHRa3rG1wcw93lUcGsWbHivp1xEtgQ==
X-Received: by 2002:a17:906:d0d6:b0:a45:ad59:cbc6 with SMTP id bq22-20020a170906d0d600b00a45ad59cbc6mr4854561ejb.26.1709813025630;
        Thu, 07 Mar 2024 04:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkOsNkSbSWrdILA3gdj5tvVPYGAp9e+2hbBtjkj97Mvl8uK5uIlfO4Po0JaXdpqZlJZ0dceA==
X-Received: by 2002:a17:906:d0d6:b0:a45:ad59:cbc6 with SMTP id bq22-20020a170906d0d600b00a45ad59cbc6mr4854540ejb.26.1709813025287;
        Thu, 07 Mar 2024 04:03:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d12-20020a1709067f0c00b00a4495c51f4esm6967642ejr.39.2024.03.07.04.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:03:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 10940112F37C; Thu,  7 Mar 2024 13:03:42 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf v3 3/3] bpf: Fix stackmap overflow check on 32-bit arches
Date: Thu,  7 Mar 2024 13:03:37 +0100
Message-ID: <20240307120340.99577-4-toke@redhat.com>
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

The stackmap code relies on roundup_pow_of_two() to compute the number
of hash buckets, and contains an overflow check by checking if the
resulting value is 0. However, on 32-bit arches, the roundup code itself
can overflow by doing a 32-bit left-shift of an unsigned long value,
which is undefined behaviour, so it is not guaranteed to truncate
neatly. This was triggered by syzbot on the DEVMAP_HASH type, which
contains the same check, copied from the hashtab code.

The commit in the fixes tag actually attempted to fix this, but the fix
did not account for the UB, so the fix only works on CPUs where an
overflow does result in a neat truncation to zero, which is not
guaranteed. Checking the value before rounding does not have this
problem.

Fixes: 6183f4d3a0a2 ("bpf: Check for integer overflow when using roundup_pow_of_two()")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/stackmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index dff7ba539701..c99f8e5234ac 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -91,11 +91,14 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	} else if (value_size / 8 > sysctl_perf_event_max_stack)
 		return ERR_PTR(-EINVAL);
 
-	/* hash table size must be power of 2 */
-	n_buckets = roundup_pow_of_two(attr->max_entries);
-	if (!n_buckets)
+	/* hash table size must be power of 2; roundup_pow_of_two() can overflow
+	 * into UB on 32-bit arches, so check that first
+	 */
+	if (attr->max_entries > 1UL << 31)
 		return ERR_PTR(-E2BIG);
 
+	n_buckets = roundup_pow_of_two(attr->max_entries);
+
 	cost = n_buckets * sizeof(struct stack_map_bucket *) + sizeof(*smap);
 	smap = bpf_map_area_alloc(cost, bpf_map_attr_numa_node(attr));
 	if (!smap)
-- 
2.43.2

