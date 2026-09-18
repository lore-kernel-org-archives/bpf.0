Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684D38F62A
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 04:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704569; cv=none; b=WDCsfYxC3T+eldYvK6rX1gd5WPRXOCq8925MzQ1n27U4Ji1cVaLZ1JkWJuD8DytKCUVv6pWymYm4Xdk08s/YHy7iJoxgHUzVlm9RVr+azcox8pxg4moPOlP7YBEZ/C9OjC403JpWQStFHvBrTBheoLlai5gs2VsTlfB29N83zWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704569; c=relaxed/simple;
	bh=DCaXGWgJB+BbxZ783ynQPEB9XIobir1FbEkbx6yR7NE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ciUorBkhs1soxezvdxxC62gVVneWiFFlK6BNBCXdd+GmV5Ajk+gXLAHGwLpIkkSmWBhzVc9UomZX4ze0V7qv0oo2PR3a89hRACVauiPz7MfqZKoOVJ3cbfzWv+Gzz5ADNLa7V3gFYwGFfKL0fU+V68e8VUo8Jawu314dtdgVRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IVE/c6yK; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IVE/c6yK"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d959904658so6117275ad.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789704567; x=1790309367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DFiLeZGvWq+dakxMGB3ux/Ej6CMDx9xCb4iJjBj/l6Q=;
        b=IVE/c6yKOF2zJwV9KozcgkIlhOFiejNL2TZuWUtgvfCGpjOgJkja/VIuRf8IoIalaV
         VxyonUrXtrfYJoQJ/G1zYGxVa0NOoal7neuW3+XhAsBq278kfnubszyNjkz2+Q7zX+pV
         Ny0EeyYJwZ8auu1+1p4u+sE0v0TmERFQnO55vh5UhXg6QyZTeP5n1tJFqyiMWZD1xxKz
         uTmhWQ6EnyywIEmoZpiMi1tve9s+ZvNLwXLSyePoCrO9zoUmel2fywd+WqDQbn6uCyse
         RFDtrFWQ7IPgLYPkI0mHtiY8Ob5W/y0PZB14yJggLnk8ke+Ji1+FyCLehjIv6NAytc9g
         OBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789704567; x=1790309367;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFiLeZGvWq+dakxMGB3ux/Ej6CMDx9xCb4iJjBj/l6Q=;
        b=E5GHrJbyRvLU5iSgEnx2loQ8CAqCA119Ke1G7+D4oFHTuN81HWCCt/Hvzwe5f2mKnA
         LmnWPAWyd3WcckWCAer8bZf5NBQFl4DeP5UbJr2oBaut/Mq0SiMIXU20R8rZeSRQJ3La
         rol//dvpWxg+H0GKx5k0mbMqmTEJJcvUPhm1+sqoB04g9V0JCc3V6+MO5rrQDA9Rsd/z
         uVlZIjGHn0HSCPS8GImAfIgi0AkRT0INeaAQm8u0dLbLmAR9P1ngajMbi/v7S3endk5B
         iiMSLxqAkOng5Yt5SnMu4dIwkXZM8z71c6s94EubroUFbTGSpfM7aMdXdWO/KoVjEk+t
         Zqzg==
X-Forwarded-Encrypted: i=1; AKwUvByKC5T/aI80D2HeCHT4CM33ZQtIp8WGhLgG30RdDLjdby+E+Yvsw28KLYjUZX6gSZIxzUo=@vger.kernel.org
X-Gm-Message-State: AFuF++l100ujBXEKVwGuXRy5YWob0aJTkrkcjnx9d5MpAYRxDMlx6N7u
	GnETZQq2AzZob5od/G7TETs4abrGCTDANYt0s4uvgkKodwRRnhiypQ7RLazkDns2uQLGYJEyAOr
	xoQ==
X-Received: from plcz19.prod.google.com ([2002:a17:903:4093:b0:2db:36c9:8778])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48e:b0:2dd:6665:9ff7
 with SMTP id d9443c01a7336-2ddb1c17043mr23032735ad.22.1789704566473; Thu, 17
 Sep 2026 21:09:26 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:09:18 +1000
In-Reply-To: <20260918040919.3402577-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918040919.3402577-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918040919.3402577-2-tweek@google.com>
Subject: [PATCH bpf-next v3 2/3] bpftool: Compute light skeleton ctx.sz
 without relying on links
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

When generating a light skeleton, gen_trace() unconditionally sets
skel->ctx.sz using (char *)&skel->links - (char *)skel. However, if a
BPF object has no programs and no struct_ops maps (prog_cnt +
attach_map_cnt =3D=3D 0), do_skeleton() omits the links struct, causing the
generated skeleton header to fail compilation.

Compute skel->ctx.sz from the end of progs (if prog_cnt > 0), maps (if
map_cnt > 0), or ctx instead of relying on skel->links. Also remove the
unused opts.data_sz argument passed to codegen().

Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" an=
d "gen skeleton" command.")
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
No changes since v2

 tools/bpf/bpftool/gen.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 1e55f0e67d91..b275373b3781 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -711,7 +711,7 @@ static void codegen_destroy(struct bpf_object *obj, con=
st char *obj_name)
 }
=20
 static int gen_trace(struct bpf_object *obj, const char *obj_name, const c=
har *header_guard,
-		     const struct gen_loader_opts *opts)
+		     const struct gen_loader_opts *opts, size_t prog_cnt, size_t map_cnt=
)
 {
 	struct bpf_load_and_run_opts sopts =3D {};
 	char sig_buf[MAX_SIG_SIZE];
@@ -742,9 +742,16 @@ static int gen_trace(struct bpf_object *obj, const cha=
r *obj_name, const char *h
 			skel =3D (struct %1$s *)skel_alloc(sizeof(*skel));    \n\
 			if (!skel)					    \n\
 				goto cleanup;				    \n\
-			skel->ctx.sz =3D (char *)&skel->links - (char *)skel; \n\
 		",
-		obj_name, opts->data_sz);
+		obj_name);
+	if (prog_cnt)
+		printf("\tskel->ctx.sz =3D (char *)&skel->progs - (char *)skel\n"
+		       "\t\t       + sizeof(skel->progs);\n");
+	else if (map_cnt)
+		printf("\tskel->ctx.sz =3D (char *)&skel->maps - (char *)skel\n"
+		       "\t\t       + sizeof(skel->maps);\n");
+	else
+		printf("\tskel->ctx.sz =3D sizeof(skel->ctx);\n");
 	bpf_object__for_each_map(map, obj) {
 		const void *mmap_data =3D NULL;
 		size_t mmap_size =3D 0;
@@ -1473,7 +1480,7 @@ static int do_skeleton(int argc, char **argv)
 			goto out;
 	}
 	if (use_loader) {
-		err =3D gen_trace(obj, obj_name, header_guard, &gen_opts);
+		err =3D gen_trace(obj, obj_name, header_guard, &gen_opts, prog_cnt, map_=
cnt);
 		goto out;
 	}
=20
--=20
2.55.0.1082.g2b9226bbc0-goog

