Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491465;
	b=AbljOqaJSM+ySI4HZCo8zypFfAEEj1f/8d5b35k56G2zkdf3R2rLaa9pU9et+BkL4MoK
	 TXvn8p+OhDVE4hvAxru7BbwQbjegTdhPTZdQP+HGh0aaP6yLovigP4oJi/mqURUcrdyV7
	 Dzg8Gygh9AAZ9kovPofZA1ia2JIMZ01YF7WXMHhEfxsrlkBhkTCbUd7YhK3SH9mdv+ESp
	 9lWddqK4YlXX3kwyF91aMwWudpI7Uk5I4qZ3M4jtZjdXvZw4xSWT4yICJN2u/Zy5hgMFo
	 r9gVLU6gbof9DuSMRMvxoH1cFaxuzWHEzIez0RnhiOqSTwWYZmzK8nC91beF9yL58Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QBfpBqH9DfyEOdhBhH9UadavYWWE9bgXFu1+ss9tjLw=;
	b=K85brx7lwsYek3KgMRjzEOzdlLWI60pM7rOiLQrNDjrzSfDaUHoCo+Xsb9q6VzuXqCc1
	 tuajCs2nj9nuj9svxzDsu2xG7ayyg1nC8xNAky1GV8oZD2TBVb4YiQp6keBHfYbd71G4+
	 jXHPJaJxJDoYnwdF6hSrV4yo0RFGt77+0Aawl/FjNkSEjS//M8RV1RQoHkBX5Et69QddE
	 yRNgFx2ZuS+Gz8AvR4qPl31FTFXDRU+eVc/ikTdtCXoNaWrwYOGR2YXMsA+YbCjEbFBjj
	 NgUm4hiPy7hC5rL4ZWMtKuUlS16NGvb0wsdG2+N8raYo+rZ2DRKyqtAI4YEU848hbaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LvOJsOzE;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84599606A321
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 13:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84599606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LvOJsOzE
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e97ddaf3c4so19835635ad.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 05:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794491464; x=1795096264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBfpBqH9DfyEOdhBhH9UadavYWWE9bgXFu1+ss9tjLw=;
        b=LvOJsOzEgbgl7nXZFUpikpO+sPH215DynZNktvAHyYkp3yom0zPzdYGSDcZkvgaOUb
         MtTwYR9abNDhvoSjpVwNtwDHT0X3B8CRNwvoLRgoBnhyT/9JHadf/NWhIzJ0bGfA8oW8
         RKpb2E2W1KcLaw+dyN74Nc7nTgA+4sELAebw4GDl6EvRaZVad7aZBdN1UQjh11O73qPX
         i7WSeVw9YyHuU2zdGt3fkV3uUQDCtIHCvcAtl+B8vrGWYU2XLYUhOoOo5s+PMDUwxzY7
         hLNf5oIFViXMTUUnavPGDuHMpr1Qa0JfInwKPzakXge+I4ZG7CqlnEA5bOVOTB6YetFZ
         9PPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491464; x=1795096264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBfpBqH9DfyEOdhBhH9UadavYWWE9bgXFu1+ss9tjLw=;
        b=i24CN/WyXTd/g4rZIQNsT+kwKjklKv5CHGsAsESx21q6NU18375OVlE06msFKSFI/s
         B+PSxg9g5slMTerYFt9ZUWzgytHKPLahEPmNGgzjngMP3r7L6LThpinoCURyzmzpeYZR
         bWX3upaPsAxjyp/NiZ/mJiZY453FmMSJB5guJ0qicC7fm7k6s7VaRpgYzWABBqmtXnIR
         qvaqdGxRrMZsJTwNvtBQJ7Gd4YvKupi0xAeAdvow/x5I3TkYUg3vev2IxT/LufNjGgUY
         QQ/P9KnGoOWLyA8k0lTo1rqpR0kdVjeqkTabwAAmwD5xdAFqHoKQ/NIcru6RgbLotcVf
         yKKw==
X-Gm-Message-State: APuU4Z/3yTjmdBM1/Q970n3tV5Z+gelfqLbZkRXo4PV/VpYq/rewFZ1I
	C5kSUyPx40rPG4CaLlTkUfJAjpyt8a9luUyegCMt8NoJG67RsYd3tFtJGdPMocy7XKVYDg==
X-Gm-Gg: AYBFou0hbGXQCiUV6r356aUbubk38bAZQsUNm1JElfLCqPTgNbyiqpYzGNZn4XHYm9o
	Oex0u1pNSv7giqJGVDlxKLQMN81wv5XmtMnNKIY70CjMUfTd1DNtM2EHflFJ/nJbOn2Ay0/cBR+
	54acRroeB9FhIlF+dkuqazUlg/SRgnrfp1sfOn4ovZ87qSqSGCn9grPhj2OTZPXfsUhVuCG8xYx
	H/0FYpTeJ/geZxe7dkVxJttEXNBmvxMVka9H3j5Qb7btg9irqiUZpYFFYstBANS2O0HbVPyHoro
	NgbgdTyRS/dz8ZXtHP3HJgQFyiz8OXA21IgOyDCDKEzrvoKGhEFuONm5Hy45FvaUOT1T6b2Y80D
	zfijMh/WbGg8Ab3LVjYXBSaS901FTvEfXOq2oP1MHs4SZzv4suOt7kk4iekqP2HqXaSkXbZRaZX
	ppL0cDKsl5tgNAXvvQaIJY6aAzk6AD2S2rhQazrNBPcWpiJXfKn8bAaYlTYAvNyWVkPNbOx6MSd
	P4HhV9Xc7nZYWXvfWlbz4FG4bz9JTCIOnv3WIcmMAsOpK2RAb5enOmQAn5wSeIx8GE4lL9H/uu2
	FhAnvwlk21Y4LMZiEySXeAvEUdSd7UBW6eV3s24SkaH92PM=
X-Received: by 2002:a17:903:3bac:b0:2e9:8510:6acf with SMTP id d9443c01a7336-2edd7748dc3mr60985655ad.25.1794491463730;
        Thu, 12 Nov 2026 05:51:03 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6e0f9ffsm35078015ad.75.2026.11.12.05.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:51:03 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>,
	stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [PATCH] bpf: Fix cgroup link update after a failed effective array rebuild
Date: Thu, 12 Nov 2026 21:49:41 +0800
Message-ID: <20261112134942.288831-1-shlomojune6@gmail.com>
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

replace_effective_prog() uses the position of a cgroup program list
entry as a physical index into the effective program array.  When an
OOM detach falls back to purge_effective_progs(), the detached entry is
replaced by a dummy but the other entries keep their position, so the
list position no longer matches the array index.  A later link update
then writes the new program into the wrong slot, leaving the old
program pointer in the array.  The array does not hold a reference, so
the old program can be freed while it is still published.

Translate the position to the corresponding non-dummy entry before
writing, and use the same helper for deletion and replacement.  This
covers both regular programs and cgroup struct_ops entries.

Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_effective_progs")
Cc: stable@vger.kernel.org
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 kernel/bpf/cgroup.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 57a785241d42fb..db3f173e83c693 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -403,6 +403,28 @@ static int bpf_cgroup_array_length(struct bpf_prog_array *array,
 	return cnt;
 }
 
+/* Return the entry at logical position @index in an effective program
+ * array.  Dummy entries left behind by a failed rebuild are skipped because
+ * they do not correspond to an entry in the program list.
+ */
+static struct bpf_prog_array_item *
+bpf_cgroup_array_item_at(struct bpf_prog_array *array, int index,
+			 enum cgroup_bpf_attach_type atype)
+{
+	void *dummy = bpf_cgroup_array_dummy(atype);
+	struct bpf_prog_array_item *item;
+
+	for (item = array->items; item->prog; item++) {
+		if (item->prog == dummy)
+			continue;
+		if (!index)
+			return item;
+		index--;
+	}
+
+	return NULL;
+}
+
 static int bpf_cgroup_array_copy_to_user(struct bpf_prog_array *array,
 					 __u32 __user *prog_ids, int cnt,
 					 enum cgroup_bpf_attach_type atype)
@@ -432,16 +454,12 @@ static int bpf_cgroup_array_delete_safe_at(struct bpf_prog_array *array,
 {
 	struct bpf_prog_array_item *item;
 
-	for (item = array->items; item->prog; item++) {
-		if (item->prog == bpf_cgroup_array_dummy(atype))
-			continue;
-		if (!index) {
-			WRITE_ONCE(item->prog, bpf_cgroup_array_dummy(atype));
-			return 0;
-		}
-		index--;
-	}
-	return -ENOENT;
+	item = bpf_cgroup_array_item_at(array, index, atype);
+	if (!item)
+		return -ENOENT;
+
+	WRITE_ONCE(item->prog, bpf_cgroup_array_dummy(atype));
+	return 0;
 }
 
 /**
@@ -1175,7 +1193,9 @@ static void replace_effective_prog(struct cgroup *cgrp,
 		progs = rcu_dereference_protected(
 				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
-		item = &progs->items[pos];
+		item = bpf_cgroup_array_item_at(progs, pos, atype);
+		if (WARN_ON_ONCE(!item))
+			continue;
 		prog_list_replace_item(pl, item);
 	}
 }
-- 
2.43.0

