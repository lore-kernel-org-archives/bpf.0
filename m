Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953C332615
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927886; cv=none; b=NYkFwETrKtp47B7NPseyrTn7eLe5z9dYxQqDnCP90faZBpAKwoyrBiNwQr5e8NmX5SAoAW7MiUfC9njNo5tYstziylLGE1xqtV053deHtbenMX0OyudR5GKBMoq/c00mQ9c+RYGObgdOxkRaXWfMcQ5O+tEPznNWoDD784vjmnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927886; c=relaxed/simple;
	bh=K4EJnp/OtkGUkU5fqwk5wI56dSk02gYF3Hq0gumu0NI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gGep84rJuEhMJNfbdSCswFagMICRd4j0VUhBLwPwoXS245LmgPOXv2tQwGeP9h1xr45OB9d8eZC7V2oq7EDhe57rYpn0WTW7vmxb7BKq9u0tx9OSI0khRFwAUeu8jJQIg1uowlk6wQ0JGsE3ZAtA4pDkYeLAkMHUcvkmmTLyJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tB9dn3di; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tB9dn3di"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb92868263so4554937a12.2
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 21:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788927884; x=1789532684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2OX+nWAyzcuztkMjIO1ryU+hNrymKwlyjS5f829o1nw=;
        b=tB9dn3diQYnCkl0J/pgNLuil2rdKXixH5idnp35CC0mgsqtMpx3gGRM8M6NdM0CyvJ
         dD1Dah3Zfu9GFrG5142oEP8glVhly0nSaikB/cAzSQWFatoOtGYZF3uiqKsqMWhPC3rM
         rwfKI+9xe+QsJaETT5V+Cb/wmDudx5g9aINrJnkLLlirIbAWTAUL5ajecmO3pb6J3l9r
         sdg1ppswFnCmrwRZ+4JuZbKs3yf6AidClcfQNHBjGk1FkxjnQjMpq7ru5nV1Te04ErVR
         795+9m/O8rfJLRqsVXomEH4iiMH8NbIqALM28F5xhzqg673yp+i8+d3jycD9DmfcKQVm
         rLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788927884; x=1789532684;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2OX+nWAyzcuztkMjIO1ryU+hNrymKwlyjS5f829o1nw=;
        b=H8VXFiEmsGNnwvS6DS8NZjN5SlCWuoLvAdhb+UtU+XEwzvN+3HFvT6jzFnSG/zjfBN
         htQxmcIJnlx0bqBKPTLVvHu8Hekhbkqi14sWCASGNgxT/C/6BfLI3qzTL8XWFoXppGtt
         /vKJ75oe3kZtgAOTAp2hAb4qoDjBXMXYsbYeOm7DMcGpH5vUh+49uzJBpmQYrgUh/djm
         KpnUqhEBMILyV1MEKV6AoWF8upC7hb24z2/fFCkndsOZg9Skw1I6teKn0ByAKpjD7lKE
         l7d9+NDzNyPtqukigm+ZtbdRp2wAESKonF/KqzUmg87tmLNK8SyPOeWM2vNVp7hH3Riq
         uWfA==
X-Forwarded-Encrypted: i=1; AKwUvBxj9EFH9TYaaCszPIyhBS7ei1nBiE8bYXeKj3TZwC0JNWfcPCBOys9M///eXrK5jBJL5oc=@vger.kernel.org
X-Gm-Message-State: AFuF++m/+YxeSNAqcvTtRDoMuQJRc7XRob+KPTpeDyotYWAe0InRed7M
	tgjYm9qYgdUu5S1A/uXImLcuGJVgIWSFKEkoHluLLtJAFYcY6pVD0RJa6PSf5/wcUo0dL0j29hv
	fHw==
X-Received: from pfbgh5.prod.google.com ([2002:a05:6a00:6385:b0:84e:a25:1e6b])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2187:b0:845:e440:d0ca
 with SMTP id d2e1a72fcca58-86166ac231bmr43259395b3a.8.1788927883755; Tue, 08
 Sep 2026 21:24:43 -0700 (PDT)
Date: Wed,  9 Sep 2026 14:24:33 +1000
In-Reply-To: <20260909042433.1775591-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909042433.1775591-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260909042433.1775591-3-tweek@google.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Verify program FD after
 non-autoload programs in lskel
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, KP Singh <kpsingh@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In test_global_percpu_data.c, dump_percpu_data is defined after two
non-autoload SEC("?kprobe") programs (verifier_strncmp and
verifier_snprintf). Verify in test_global_percpu_data_lskel() that
lskel->progs.dump_percpu_data.prog_fd is properly populated (> 0) when
loaded via the light skeleton.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
No changes since v1.

 tools/testing/selftests/bpf/prog_tests/global_data_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/to=
ols/testing/selftests/bpf/prog_tests/global_data_init.c
index 7c539cbcf3a1..ebda60200b71 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -214,6 +214,8 @@ static void test_global_percpu_data_lskel(void)
 	lskel =3D test_global_percpu_data_lskel__open_and_load();
 	if (!ASSERT_OK_PTR(lskel, "test_global_percpu_data_lskel__open_and_load")=
)
 		goto out;
+	if (!ASSERT_GT(lskel->progs.dump_percpu_data.prog_fd, 0, "dump_percpu_dat=
a.prog_fd"))
+		goto out;
=20
 	map_fd =3D lskel->maps.percpu.map_fd;
 	prog_fd =3D lskel->progs.update_percpu_data.prog_fd;
--=20
2.55.0.979.g7e5102b832-goog

