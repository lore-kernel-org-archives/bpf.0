Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D0396572
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503826; cv=none; b=miXngMO0OzXnllOEHa1h4KuAlPLopHXr3joOtgi4HP8VBkv12D3JKCBJo+rghLEPcaDYiaQ1z+e0Em9Lys0GNoQP0a/T9nYRUJThpC+28G6SS2/HAnN+StPv0WKzs6mns8QcPsGAwaHdMl8TfxnP5SvkZxgxv3IydLIheKUd7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503826; c=relaxed/simple;
	bh=DHGo+nMhwLb7jF36KxW3cOWZ2EkkCRxXubrUxi275uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2uvA0chAoBdVJH6tdtJfjLGvbDNgMX/GckZJUiM8kLlwhLTudEG1zZJL/Yx9m5CQuJBY2FrGTtqK2ce1KOudO+WglhebVET8ZerXvVg9rhNx0r0YQRyAS/IRAI/5daubEfvgoQD443voIEOJ+Ez/yK3iAEY8SD4p78yImXNkHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WizLJ8QJ; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WizLJ8QJ"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so3653715e9.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 23:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788503823; x=1789108623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nnl0L190XFrilVSAmY8S3ZopotWsd7P+T81I3TNIBtU=;
        b=WizLJ8QJklp3BURBdKxR/WMMhFiCWV0wlMLhSEnHYV62+RrJqJmoL3Zd5dIrtFzK7P
         dQdvFj30QDR7wpRmy7JeRqZKvw0pvIJJYsGAxbKuywzrnQVxN9qAWxnQ++t92BYVr1uX
         +WMMw3HyqWJMVGAXcxRVVVbckbjwKzjk1Q5KPJ/QigQF2ZduiFhExPXkzD1G9Afc8/em
         Qkt3gIXyEWnFpI+tq/vT8kyppBloHDKBDVW0qNVQSL8/6D+Y8U44hqf53rt2AvdcJtWn
         qyEH3BU0PvY1QfGonh3BR3zp+O/nkikTvF2aXRBMgwN3+SS6bMPYanLbuxhn3rzWRbXi
         qdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788503823; x=1789108623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nnl0L190XFrilVSAmY8S3ZopotWsd7P+T81I3TNIBtU=;
        b=r5ao7e0Iv21ZR7mSr9ICCxlAixRut9+pjkRX3lDVEtnKE2cq9IVjHMmN+/kZznlyhr
         r6eCmvJdwsOvUqSW0F08Xo6wx/Q6gipkc9t0m0xJz/z2CoRd/jMwXP62uZ8T6bjEtaqk
         QEQbadp6x5AYFpr/Ph2XmTsOS24Etx6DjXvvU3diHSNw3lXkJn7NeoloSGj/WypOItsu
         WUkfMFNcp8gqYPnv9ZDxE4a1dMD4+7tcKTWZlfiT0VtdWNE86QI64w3za0tDLYX+ZoiO
         T82v/SGkYwOuybKgDF75YotfC6O0c5aV+4XBduE7ZA/RnKO68SMYxj+XLscHP3i/aCEh
         wmEQ==
X-Gm-Message-State: AFuF++lnOZ1eRBd2MZ8nf+0i6qbrrjyOMcN4vxkVD3pGU1CXHKEl9O3P
	fL46RIDFx1AJkUn4WpcKEP6nihGnL9imTEnHK6DfoeH0w0NSHJTjR0tF1K5CAyIT
X-Gm-Gg: AYBFou27yVZwQsMi9yGIh8amwZVFxItazi6bdczUW2rO+NBSKRDw/tQE/nGnWwnz0oq
	o78F/dZPSiEMYywJ9qRmj4zq7MX7RTzcX0r5ukObyIpLAmZmj5cCNM3tbBpMJdLfYwfjjMEJGQb
	mhPP0syylsoIFgKmi1LwtDxl92/hbXisgRssXKpE/WJE5dNruUjcEYOu8Mt4LytrXqHCFLccHaI
	x5CqNuhccMFQ9WgodUC7nvoTnk3eTZ3OFigNTtZWYkStFVpMWDrPbNmQTOjLQzWc9FWJHJYY7hU
	LpsZDnuA3YZ/ERLd9sxAClLyfepBgF2OM92f3qDTTcX0lThVP00+855A/VK34RHt028Zc7RaYo5
	BVimR8gubqmcec7Kl+WXwGWdm0dSGs4d3hW+ys6ooBcLsSnz+eY+5XLoQb36xhv96RPDxHMqg4Y
	xKAPorNVCVVl3wJufxtZPpCFkOF3AKfxexL9sXaMPcHGNdplNueq6M3qUS+gom30xl0DUmWoHo1
	Sa+wKVSCay0tMGJMecflkNJP4y9UCYv6NTdiwdlBswWNl0ghsdtkQylzwrGlwVT26FMEDgULjiY
	ZmK+JNGjmnw4DN73Qc/4Izm+EYLOsPWEheOD/w==
X-Received: by 2002:a05:600c:4e0e:b0:49c:fc6c:be0b with SMTP id 5b1f17b1804b1-49cfc6cc04amr9510835e9.17.1788503823217;
        Thu, 03 Sep 2026 23:37:03 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm143818985e9.13.2026.09.03.23.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:37:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Ning Ding <dingning04@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 7/8] bpf: Reject untrusted allocated-object pointers
Date: Fri,  4 Sep 2026 08:36:45 +0200
Message-ID: <20260904063650.3877826-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904063650.3877826-1-memxor@gmail.com>
References: <20260904063650.3877826-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928; i=memxor@gmail.com; h=from:subject; bh=O0xbawAqnBylYPa9BBYqUadEoCJXb0J5+JGJNj8vDJk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtW2uWnZetvbmi1eTnh6ZKWjydXmNavumCckH/Yur7I/ eLC6U81OkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRm/MZGZbs1UyZpnqrVWLv /ruV9rM7fabZnXv7OWdlX/0K0Xky5vsYGVaftph70uHLdZn5gjKqOf9+Jr1fGpy6Z+Kqn8sY+Q3 6//EBAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Ning Ding <dingning04@gmail.com>

When the final RCU read-side critical section ends, a local kptr is demoted
to PTR_UNTRUSTED but retains MEM_ALLOC. The pointer may be NULL or may refer
to an object whose lifetime is no longer protected.

type_is_ptr_alloc_obj() nevertheless recognizes any PTR_TO_BTF_ID with
MEM_ALLOC as a live allocated object. In particular, a refcount-only local
kptr never carries NON_OWN_REF, so it still passes the
bpf_refcount_acquire() argument check after RCU protection ends. The kfunc
can then dereference NULL or stale memory.

Make type_is_ptr_alloc_obj() reject PTR_UNTRUSTED pointers. Since
type_is_non_owning_ref() is based on the same predicate, graph kfunc
arguments obey the same live-object requirement. Fault-protected reads of
the demoted pointer remain valid: writes are already rejected, and read
fixups use bpf_may_fault_on_deref() rather than this predicate.

Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Ning Ding <dingning04@gmail.com>
[ kkd: Rewrote commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1339c2f028db..36b65797877d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1381,7 +1381,9 @@ static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 
 static inline bool type_is_ptr_alloc_obj(u32 type)
 {
-	return base_type(type) == PTR_TO_BTF_ID && type_flag(type) & MEM_ALLOC;
+	return base_type(type) == PTR_TO_BTF_ID &&
+	       type_flag(type) & MEM_ALLOC &&
+	       !(type_flag(type) & PTR_UNTRUSTED);
 }
 
 static inline bool type_is_non_owning_ref(u32 type)
-- 
2.53.0

