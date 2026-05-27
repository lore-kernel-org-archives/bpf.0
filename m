Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29340488C
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886389; cv=none; b=WgGB1xywQ3rDXfTbBqt/n96Ov4GKuxPnFw3m8zmXSf41YpuR8K59MDBMUlVLR0VvhXf1i8ok1DUpVPVWSwVaO6k8AMdtDEHghquQxDXzicqRG0N6W304JwA0sjfOfAomku2VGJZ+NqcYV37nCYdyce7SWGsLug4gbah2w4OJpOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886389; c=relaxed/simple;
	bh=pa9xHpIMy4cwaB68Gz/882zX24JlvRwx90PkqPToS4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IG4dz2NcggDGYrb25JxanROabMrGKjFMGnik8KRXAqMdHKjbc8YqyeVNui37O9k6Nr9KQpLYXrsEQLbpHzKifUGiJkTvPhX5ovCP0VFSg0jyoKU9XWCy4MgEhfnWsflOvI+ouZwaFd1Y/kt1vSkjgCkNVLx9+KokXcGrWgbVlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qFEL6QG/; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qFEL6QG/"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45e55c44ac1so9242733f8f.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779886386; x=1780491186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bq3wICohzMAvkHD0Qy5vcKjARM6gmOVOBkurJ/O1FNc=;
        b=qFEL6QG/FGJ/nAUZVjaKD85YS+tYcIsDbB9g2oUskdzqsdrWqjuKP8K3Ms/Sg7YYmM
         WvrnwVRY6REPskttIKB3qXlMb6Ia0MblAx62WPiFpb8VMPYyLJLr2d3jVd3XET1wVlX2
         9bnNU3nA4+EMlv2XhyRsz7cIRGeXq6o+9iUxuduhohtfIc73qUSgDWW/kVKhR7KjHOmJ
         16rgcmqoil9dGrBvxJzLB9eCFprVv1N6JOVlEK0/v63ZrKa2ITeK3Ndah9T2frGCaVXq
         k0IMA0rhUliuTZrVQilxrrT2yMJZDeh9HqBmyndCeK/Lp3A5XSIjS6gL//IDAo84jFWD
         a7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886386; x=1780491186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bq3wICohzMAvkHD0Qy5vcKjARM6gmOVOBkurJ/O1FNc=;
        b=sOJJrTU4LYD0rtRHpKx0Hw4QLl96Bs7nuQPp7RKyWcBvh8BFPIUCLqBpRpG9fDlcLO
         kfEsBGVC2YYcWpcAz8iIHdcSV42rvZWw7jLfksD/Q7V5KJNwGG76tVQWVanqZbtYkKbP
         rXdPZPGILBM8jFOWI2D7Hd4hRHyoDxU+6vXhnMirJ6d6q5SCPS9DAsB2TFHySzX7J7us
         NooCMc36t1IK5lUnWz0orU5HKFi6f36NX00vXuAmP1Z5Y2baWRWr/F89RgRGASqeGkmw
         e19tf74Gm7OGkCaO/JJL3ngFPzQKBItwJ25fi+oNBCg71mlNp287NoG4+0W5/6z7gS6D
         aUlg==
X-Gm-Message-State: AOJu0YzMYGwAWbSqlMuIpO7v0Q/Mw2AffMpC3I3xOdEbn/BxfDFWkpcN
	PvPF0TiuVrho5aQ24sKJJpCziTzFHQ4GceYRW2QmvQ+gVLUWcag+2V1mlmWZsKeQ4C8RowBAJBT
	Kq1E46M+4mXJW6o3R4g==
X-Received: from wrim3.prod.google.com ([2002:adf:e0c3:0:b0:43d:733a:c37e])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:470a:b0:43d:3004:5fef with SMTP id ffacd0b85a97d-45eb367fb4dmr30997013f8f.7.1779886384889;
 Wed, 27 May 2026 05:53:04 -0700 (PDT)
Date: Wed, 27 May 2026 12:52:58 +0000
In-Reply-To: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-2-27daa15487a9@google.com>
Subject: [PATCH v4 2/3] libbpf: zero out btf_key_type_id for STRUCT_OPS maps
From: Siddharth Nayyar <sidnayyar@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, gprocida@google.com, 
	maennich@google.com, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

For BPF `STRUCT_OPS` maps (such as `sched_ext_ops` maps), the kernel BPF
subsystem enforces strict map-creation safety validations inside
`map_create()`.  That is, if `btf_vmlinux_value_type_id` is set, the
kernel forbids passing any userspace `btf_key_type_id` or
`btf_value_type_id` (they must both be `0`).

However, inside libbpf's map-creation options initialization
(`bpf_object__create_map()`), libbpf zeroed out
`create_attr.btf_value_type_id` but does not zero out
`create_attr.btf_key_type_id`.

Fix this by explicitly zeroing out `create_attr.btf_key_type_id`.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b159faae7f9c..f9c653541005 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5440,6 +5440,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 		map->btf_value_type_id = 0;
 		break;
 	case BPF_MAP_TYPE_STRUCT_OPS:
+		create_attr.btf_key_type_id = 0;
 		create_attr.btf_value_type_id = 0;
 		break;
 	default:

-- 
2.54.0.746.g67dd491aae-goog

