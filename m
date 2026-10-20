Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508207;
	b=1X1tCRV60YdEnKpSekAaWSaMzz7tyrOX22J8wSww128fYIVze4leyJG//UJz/XqRzSCh
	 fiHiMpJJkU9cODfNXlD917K6r4z7Gn422Hk0oK2remdsvEZoLs0qMQs2xzHHzYbHPLPXw
	 XnWEgBn87HssD13C0v9eGiWH2Kp7aoR8yhAeA1uxQLTiLVWqwynvsXlo4HOMqwA97MJI3
	 KN91RkFy/ofi0OiFfaD0q6RRsdkY/cpgowhGqOKk7g60fve9PDO1u5YU82ag/AzocXzwv
	 uMCUdPqOKd/14FX0NtXXLtVZOn3FfoOanZT4YgrzFe7Rc2m/qKH0Dd1Xo5a015dl89g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2s0nE4bPfCL8IRN5Acar+iOzwaCVoCTtQF/5Nuxgvqk=;
	b=lwk7rLNHx/BtLNg+HxYk17m2ZZ4LY+KFoQ+DVffdPz/btjxowDd2J7wGX6sFmY8K75mk
	 /RgNWEF+lZ4IKZ0lL562/AMLI2GpmRFasZO6h+I7l2HkPEIQwACZpPkR7oIRKUHP8l2Hw
	 SPTk4DD1YUJ09lRTjoaVV6E6OjaQAHaqpcUdbiCtRaY7avC2MiXorPENafpZARDEm8Anh
	 Iv/B9RtO/czPoNVcHex7rJHEkazZGT90xdjeoflluhJGnn4OMWsXJTkz+tpglL4Gss8kc
	 1lDcn241hIVpBls4bFB6lnStNOPX6th4apeTG0foBCt4lcL9zcSiuKeV3IdbwzFQ0xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bwi3QcO9;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117D606A321
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9117D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bwi3QcO9
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6740e7ae219so2802061d50.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508206; x=1793113006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2s0nE4bPfCL8IRN5Acar+iOzwaCVoCTtQF/5Nuxgvqk=;
        b=Bwi3QcO9pciE03V867lcNfIER/4RgGxuihuOwU7cXDnLDX2Xw/th5wK7UWjCXeQ+i2
         alOFaChW1zaezR9HFmPFqnnmkl39995Ib9qyqvRbd+JQhusRxxgh2GIXHbLGEV34UiNt
         eQxObTulKGGGUSOMte5lbp4cjyBR1cHM5Q5Hxs5ZVXZsaQxZWbJvZGqw4dijsxJdbroT
         DQSS8QGEGT1/VyX7VW4AsDqQEf8EhhVz2zXX45JjntTLbnjD9a4tQOdm+AGC42SICVmx
         moB2oAvYI+Sz6MrhdY54knvc1tGKYTRg1Hw0GwYhrMAPBmMU5dfyGgQZkTOwTkE8sAhE
         D4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508206; x=1793113006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2s0nE4bPfCL8IRN5Acar+iOzwaCVoCTtQF/5Nuxgvqk=;
        b=Bvg6aSwVKR9KZXrIBptuZk6C2nefRI7xy/x0PUGqIRIGOdvKx5JcnRvRiGkNSqibzl
         SyyLFRJhu+2cK0GdLxY/iAACQPIEH8anG+6yx8mSvhWiSKxkZLVfKWofWIUKJrI9BAB4
         5OjbzbHPoWF9ewIxsGX+PJ1vU29vBEYf3xNnV2/6XCaOKItmIRwCcRmVv+QNb0mJ/b3M
         lKG8V9iROI8eawO8GH/vbT/ZlkfphwTAbgkAgAOcNG4z+l6r7C48G6K1223JUyYR8Ys9
         QCWZqj8EZ5IIsZ35sxEAxDeUksY8pwDqtXSCKcbgBVitLtAkCE1xwot+BHHSdDRCp55H
         dMeA==
X-Forwarded-Encrypted: i=1; AKwUvBwR7JjfiHhXVG5VPsbK1X+afOOLQDeWiIUKMhECp6IHW0vhjFXcivuDyJpWSQobCeYcmJs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL70GdqAJLQLJS3mIWQ/3PVcDObftcH/PhDCxuDbG3peKxqitss
	DeqOs/l3Iwtz04y101lnydbH8RD53lR09txWDqrCb4mnBZ8mivzNgQMm
X-Gm-Gg: AYBFou30dVqeig01BIJuzSaxQd2wDSKXunRBdUbwDvqfNQL0iHADCOCiyzYCoUyIBGW
	P6RuFKFV1lXbIhlLBul27fDKqOKv9LzTkF9xJ7sblCL4v0EkNWm+PeOxmXDqHYD0EpHOvgRaIbz
	WMEEps6sZaSmUzqtljFUn56k3+hBhVEnUN1xHKcm9qF4BaILTQraEE/aZgk9wqD8Fl4Ig67vutH
	teO5psACjLuiEYSnUKiUXxCfJuDh9FIP53h0kEuSb+T3NkZ1DTYsXJuZp03PugYOQZ7mkKKC7ms
	1oRtUR6tlbfrdvYZZTqFyKFc8LAXF6rvtp0HkRYPLm0GzmZ/2uIT4VhWXw01WOCYWoOhtKcajGe
	Y4rIxhJWz5bCF/vDEWfK9l4aOMMe/AxGrB6+m7i9hL+mQcKLkHd2U+wOOndS5lh5bN4j6HYaytK
	oFSVmwzznX4OqEq3wpATEn5dNpUuFjInVDcrCy1SnTkTDpaxz4PxXAs0Mc96R3/DNECsgG48g=
X-Received: by 2002:a05:690e:134b:b0:675:b778:a423 with SMTP id 956f58d0204a3-679ca946593mr2869532d50.142.1792508206569;
        Tue, 20 Oct 2026 07:56:46 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8701:205:573e:17eb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1c98a1esm5239944d50.1.2026.10.20.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:56:46 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf-next v2 1/6] bpf: Carry MEM_RCU for trusted fields with MEM_RCU parents
Date: Tue, 20 Oct 2026 10:50:54 -0400
Message-ID: <20261020145059.2146170-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020145059.2146170-1-utilityemal77@gmail.com>
References: <20261020145059.2146170-1-utilityemal77@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute MEM_RCU | PTR_MAYBE_NULL instead of PTR_TRUSTED for fields
declared as trusted when the parent pointer is MEM_RCU.

Today, walking a field in the __safe_trusted or __safe_trusted_or_null
set invariably yields PTR_TRUSTED if its parent is trusted. If the
parent is instead RCU protected, the resulting pointer survives
bpf_rcu_read_unlock() as fully trusted: it can be dereferenced without
PROBE_MEM and passed to kfuncs expecting trusted arguments after the
parent's RCU grace period, e.g. mm->exe_file (MEM_RCU) followed by
file->f_inode escapes the RCU CS as a trusted inode. Limit the child
field's lifetime to that of the parent.

An RCU-protected parent also guarantees less about the field's value
than a trusted one. __safe_trusted promises a non-NULL field for as
long as the parent object is valid, but RCU only keeps the parent's
memory valid: struct file is allocated SLAB_TYPESAFE_BY_RCU, so a file
read under RCU can be freed and reused within the same CS.

Mark the field PTR_MAYBE_NULL as well, as is already done for __rcu
tagged fields, so programs check it before dereferencing.

Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/sashiko-outbox-171590@kernel.org/
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2f190abe3448..534200c0d27d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6684,9 +6684,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 * trusted if we are in an RCU CS. Such pointer can be NULL.
 		 */
 		if (type_is_trusted(env, reg, field_name, btf_id)) {
-			flag |= PTR_TRUSTED;
+			flag |= is_rcu_reg(reg) ? MEM_RCU | PTR_MAYBE_NULL : PTR_TRUSTED;
 		} else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
-			flag |= PTR_TRUSTED | PTR_MAYBE_NULL;
+			flag |= (is_rcu_reg(reg) ? MEM_RCU : PTR_TRUSTED) | PTR_MAYBE_NULL;
 		} else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
 			if (type_is_rcu(env, reg, field_name, btf_id)) {
 				/* ignore __rcu tag and mark it MEM_RCU */
-- 
2.55.0

