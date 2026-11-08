Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794151800;
	b=voL/yOOUab4cg6ZdFtmNqVGFl9E0iuLsQDSkuWlNnBBmOQGJSn8dVQS/DLNIZFBlyFz5
	 n0cUxDFxiUMDhXYf7ChfSzVproqs324WgJfrIB2B/LJ1E9IaIb1C/hDVU90UbuUHbCcKF
	 SxUQp+O8NnmUpjwrPcTlf08LnP4U5CEirp0+BuF/UCVoyDZMQIzBJhY/Fv7413rZK484g
	 JWUxilGpjfMdy4sxTuOYfztFYdWmRMrt1EyOjWF48jm9LMOX8/fugDOc98U/srSCBA3t9
	 rLo0krgmsoVPDNDWZfElds/UZyle5vJpFuzSqO/es5F0fO3aUUQ9KLsL8dWEzMWCcvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794151800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3n+mXMU4cMbINOJYAicimrbprQcsEkmwXcrE/1+wz7Q=;
	b=IaEnzG5o5f2fveN7igeET/Cr1dDQho9ds6zqITJO6FqSsiw/v9HMJyueLMMdc6Mk2F4u
	 xLwxLsoJYRpFVPcMt8EiqTNvVfm6w0oDRY+EBJZ5qpWBimkcRQXQCqXbXAtvtCh06F/Bi
	 l4CPq/XMnf30/CVmjlnfNmRGSzPZYKjcW3Ovz8j8yb/kFNtvBUow+OI7vCCujaUoPBvgT
	 ZNIxd2YhoEzDE6oebSgKiBY9jPPDPG87Et3Ah3yIfiwghjs617U4y8nHlZ3WaDA5c/uqM
	 o7SrmNKwgIDN3sQLgzPOvV9rjE0Ih3M0cMdMtJQzYrhenV+EuyOQSMmH/Lad7XHOCdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PMcRX1Fm;
	arc=none smtp.remote-ip=74.125.227.201
Received: from mail-pi2-f9.google.com (mail-pi2-f9.google.com [74.125.227.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0E606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 15:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD0E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PMcRX1Fm
Received: by mail-pi2-f9.google.com with SMTP id 41be03b00d2f7-cdb8dad8ea5so42565a12.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 07:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794151799; x=1794756599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3n+mXMU4cMbINOJYAicimrbprQcsEkmwXcrE/1+wz7Q=;
        b=PMcRX1FmtM9bIDkiBXVCsveKT3v9yWtWsNkdQ423u2J1flAJsMrfQOsN9L4SVrjfY6
         +A8F/ihcKh1ks69ugb+wHxXWDcaOdGAqcJ8PUZ6E7YXAM5Fcmm9CMmxxlvoOJk8HVr7D
         LUY1JPeDTNQKfqeCmDMLDcmdg2drJmU+NMUZ49auKniHOdPHSGWbodHvKqCK4TnAqs/L
         uPePlWellESTc1+KGChqm1Kj1nTE7vSZTDbA6LCUDvrjMp93AXNMrRqhqhW4D0izu3my
         kjs5PJobs4ieIwk8Dz+0nhs5PDoH7fGU6PG/t+bWSK13K+7y5tA1b8aONc/ygKQcWMon
         e4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794151799; x=1794756599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3n+mXMU4cMbINOJYAicimrbprQcsEkmwXcrE/1+wz7Q=;
        b=RtK0FEPW/OujrAhpz8vtYKLlRD4DxnKMZ3THeb0WadUDnQte19YHnB3o7s01uq1doy
         D7LFjQL8BArPvNRnchifVHid9Pp1YNqV+Wp7GN3Z38FugJtENNBPaVgQygo9f8TVuj8b
         8XgTePjXSotEkfP243Uqf7yJZWVy4dttILnSnaV8S/t9J8ixIiHSQ4kHYp/OxR9IKAxz
         XbQ1ycrkmEiys18csnA4JkrkIVEUIPtXNAwy+IuvLudVs9W7Z+SL+FBdik/ug2799mVU
         OCOgpJrWG6ZUK7FxcqLqEmIRIsbhd7UCIRR9XbLkgeUclnby6ppW88KmMLQShjiXcrfs
         4B9w==
X-Gm-Message-State: APuU4Z+YkV82gnwb+rtFPycKpR6A3PPw9nJECm9EiqEkO/a6IeOM50u3
	tqoq5GW5vW1KfA6xBnirie2EbggKPV0mH9BQX7fn/R+GvTE4QfyBiUOTkxzjOV9MWosKPw==
X-Gm-Gg: AYBFou1x2rHSVKH5lVju39EyrrdQYj5G4raGIIsnjRTdyTsag8IcKgkekwvSinRSxLo
	t9J9pQiF0o8nboeUOu9IUhpnaUh/0msAH7MDjuSbleiDU6TG2Fr3cP9C2lPj/ajKjrjSeqLxQxm
	EzzoPK4a4ZXDqwPRh5mnTp7yIFKK2KgvDaIun50aMS10E0cB85L+GiANk1Ty8M/9c8mSE5gmS2D
	3OsMQnm8yc4DIbO4sqd2P4hzi6+fzkkQqxGFOajAOl/wTSBiUypxO1la1hILwiIMzYwGKtxWwSS
	VcBHS7jLDGiaJ0faTSKFohAmaNSYa0/+GGPBFsXx6ghAoKGOCdzyMS7vf9oQBUbNiJtqJgYwfOr
	+rr319YUqtDt9XyIIM4tgJLgPvBBLW0qTisBgAsJajx+v4HHiD9co6HBM6o1Djm1SMybf+lH9H0
	yY4Lam3e/uL3vZ8NN17FAy2c9D5BsREXFtD4HciPSeBYFnhNn64SKoXXXHRl4tHTvnFeKyuAeKl
	7ynfyN+sqBL0lbO26N59otPnkh+UPKQxtXJL7/OojQZ3sJDC8O5X9zGAIbR0tdoQNzug7hc1LMa
	K5SLOnCkEe+LAzU4YAaqLbszZUrO9vTaN6OAW8/d9TvObfYn+AXbxELxLpJhiqIGjMC9
X-Received: by 2002:a17:903:1a4e:b0:2e8:7686:4d46 with SMTP id d9443c01a7336-2ed83770297mr15555625ad.34.1794151798800;
        Sun, 08 Nov 2026 07:29:58 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed8174bdfdsm4321175ad.73.2026.11.08.07.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:29:57 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH bpf v2] bpf: Check variable-offset accesses against special fields
Date: Sun,  8 Nov 2026 23:29:41 +0800
Message-ID: <20261108152941.7363-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
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

btf_struct_access() rejects direct access to special fields (kptr,
spin_lock, list/rbtree nodes, ...) of program allocated objects, but
for a variable offset it only checks min_off.

With compiler-generated BTF the check at min_off is enough: the
register cannot take every value in [min_off, max_off], since
check_variable_offset() keeps the access inside one array with a
step that is a multiple of the element size, and btf_repeat_fields()
repeats the special fields for every element.  Every reachable
offset therefore selects the same member of some element.

The check breaks for hand-written BTF with overlapping members.
btf_struct_check_meta() only rejects offsets that go backwards, so
this layout is accepted:

  struct node {
          int arr[4];             /* offset 0, size 16 */
          struct foo __kptr *p;   /* offset 8 */
  };

A 4-byte store to arr[i], i in [0, 3], passes the check at offset 0 and
overwrites p at run time when i == 2 or 3; the release path
(bpf_obj_free_fields()) then frees the corrupted pointer.

Check every offset the register can take (min_off + k * step)
against the record.  Constant offsets keep the existing check.
Since only reachable offsets are checked, accesses that stay on a
non-special member of every element (e.g. a store to arr[i].data
with step == sizeof(elem)) keep working.

Fixes: 89e72f81a455 ("bpf: Varying offset access support for PTR_TO_BTF_ID pointers")
Link: https://lore.kernel.org/bpf/20261107135419.81491-1-shlomojune6@gmail.com/
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
Changes since v1:
- Check only the reachable offsets (min_off + k * step) instead of the
  whole [min_off, max_off + size) range
- Rework the commit message

 kernel/bpf/btf.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8bf39098ba97a..738625d8e5879 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8056,6 +8056,21 @@ error:
 	return -EINVAL;
 }
 
+static bool btf_field_is_accessed(const struct bpf_reg_state *reg,
+				  s64 min_off, s64 max_off, int size,
+				  const struct btf_field *field)
+{
+	s64 first, last;
+
+	first = max_t(s64, min_off, (s64)field->offset - size + 1);
+	last = min_t(s64, max_off, (s64)field->offset + field->size - 1);
+	if (first > last)
+		return false;
+
+	first += imod(min_off - first, reg->step);
+	return first <= last;
+}
+
 int btf_struct_access(struct bpf_verifier_log *log,
 		      const struct bpf_reg_state *reg,
 		      int _off, int size, enum bpf_access_type atype __maybe_unused,
@@ -8091,15 +8106,28 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		if (!meta)
 			break;
 		rec = meta->record;
+		if (min_off == max_off) {
+			for (i = 0; i < rec->cnt; i++) {
+				struct btf_field *field = &rec->fields[i];
+				u32 offset = field->offset;
+
+				if (off < offset + field->size && offset < off + size) {
+					bpf_log(log, "direct access to %s is disallowed\n",
+						btf_field_type_name(field->type));
+					return -EACCES;
+				}
+			}
+			break;
+		}
+
 		for (i = 0; i < rec->cnt; i++) {
 			struct btf_field *field = &rec->fields[i];
-			u32 offset = field->offset;
-			if (off < offset + field->size && offset < off + size) {
-				bpf_log(log,
-					"direct access to %s is disallowed\n",
-					btf_field_type_name(field->type));
-				return -EACCES;
-			}
+
+			if (!btf_field_is_accessed(reg, min_off, max_off, size, field))
+				continue;
+			bpf_log(log, "direct access to %s is disallowed\n",
+				btf_field_type_name(field->type));
+			return -EACCES;
 		}
 		break;
 	}
