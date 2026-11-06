Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996421;
	b=r+fNgY230sz7y+t/VWYaHbe7zSnj1Yg1q8MISiA2jGC8vMSDyFyuo6O17aD+/tSGyncf
	 6iX4TCCubaS2a3y/2h/jYTMZVrBoKNDB+vqDk1QZ3yJUGZPpw/rNLUdOuCjtJNC6+3G3f
	 8wzxh+FMUFUQ+kFHm+6ADBnwk8Db9J1luQ3fKn5usMUzIK0QF91E2Y8Of3oQUcdcrMFvl
	 4sQCoH/QjjIzWrIK7tWjy19lvoln9/z7xc1Jp1sOOChP0HAzo18+V758J+y/VEcypTysw
	 On57K8lx94XODS8zwNyzcp9N56P2P86q4ciBCbwCPYtLF6WH95Tt39TtL33Lp4FjUzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=wYRpy/O7KBx8gWbkCOvTZNiGZUKxKn/aaUwwAjHzOcQ=;
	b=dG720VxMUTAV/7rniEaD9Vw90htsGjVlR7KsKq3tqSNOol5I8AUlpMFG/lsMtOjpbf2U
	 qIdfKWqjDGWOZSF2rFUuayoKvdncfW9xlGP7Nwk29FLwbfF1ZqrNRRatUcSawSTvHe0QA
	 AuVyhO/rhkrgNTxga4nf9WZHJIr9zV8jekHv72qmtY0JKaYGzK4NQLppt4lXSkJZjhEXe
	 C7vFwkgdAYMtDLCHgnNdJO/c0pGRLuBu1g+s/smL6t+gDx3LjWi3XyJ5hcwoaAwszz9AM
	 dR5vOh42agkG/lgxnRz/59yObVHyv9RsFEud9+VsRnytk6BY0CdeZWChOrgWIBNHzpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YlscIqfh;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE00606A339
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EE00606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YlscIqfh
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd66551e02cso1101607a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793996421; x=1794601221; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wYRpy/O7KBx8gWbkCOvTZNiGZUKxKn/aaUwwAjHzOcQ=;
        b=YlscIqfhbVnCLNXoHezz7lXtxhhaPr/5sO/KCNaPP+1Karteu+j1JKjalE22EoGs8h
         9u9E/2KnXV+Q0aRVOFIpiARkNxi8LmUVdNCWhNSgOm1FsxdTzAUGCmAUQwRRLDe17ITb
         DE5suTx50BRrfH6qP36VQiQwuB7MQgoYnOYHgE5eZHRH7Lz1NENI4D69VQIps0DMwadG
         C+/pOTSPqlyKwZJM7N+gl7IHlOSCbEfgCW5c/lxZ1bvc2gve3/miAE4sqahtTcWG7wY8
         sahpn0IbOc2u2j60gvMXlX/qIKq0FLLFnv9PruVupn3xWmxsUg2QcR1gP0PiMRrNshOd
         jbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996421; x=1794601221;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wYRpy/O7KBx8gWbkCOvTZNiGZUKxKn/aaUwwAjHzOcQ=;
        b=wVkiOxQR5RJfZjOnfKAFzc8x+Awvy1D04BDSxYIfmCiWkMmWNIVPLpxgs23xrFdWoQ
         DCRuhW4XQwF1QNBGWi9Hkq0NKim8gyI0Hg9BFgFcEYl9Qo3BORQobq+H5h5aWR7k9Ia7
         q8RH/wWa6Bkz/TIez4utnLlWAmjPNUCSLsZ/7rpgfdHHFcqk58pzr4JbZnY3FG4DjWVs
         d4cxze+CP9LTXycwV3hjjfhRlMy/MIZwyMcMc2+Joje/ZImyHxLkdrxG73Ojo6qTJvJb
         mdMgPqh78OjNnPSCRsGguXorKTCV88UFVNmDgBRTiLAZC6HGc2XfO9LfWcmxNyCS8xP6
         +JlQ==
X-Gm-Message-State: APuU4Z8190vbCXUNDRSi9Ban3Ho71vBy2VJZBFRcMfcto9QzJ3aRr68v
	elElzapjrTN8OHFw7MsUHiwtUIoTaFL2+YBp92/XhXA/HgZO9dY70sIIBNVTh7YDBcpxOU/mHw3
	TEmE4QUf3mlcm6tc5Mg==
X-Received: from pfo19.prod.google.com ([2002:a05:6a00:2f3:b0:88f:9775:7fcd])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:da05:b0:3e1:8890:8400 with SMTP id adf61e73a8af0-3ebb297f700mr3991183637.15.1793996420375;
 Fri, 06 Nov 2026 12:20:20 -0800 (PST)
Date: Fri, 06 Nov 2026 20:19:53 +0000
In-Reply-To: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261106-lskel-struct-ops-v1-6-a4486ffc79cb@google.com>
Subject: [PATCH RFC bpf-next 6/7] bpftool: Generate attach and detach for
 struct_ops in light skeletons
From: Siddharth Nayyar <sidnayyar@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Giuliano Procida <gprocida@google.com>, 
	Neill Kapron <nkapron@google.com>, "=?utf-8?q?Thi=C3=A9baud_Weksteen?=" <tweek@google.com>, 
	Maxime Ripard <mripard@kernel.org>, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

Update codegen_attach_detach() to iterate over BPF_MAP_TYPE_STRUCT_OPS
maps with BPF_F_LINK set. Generate dedicated per-map attach functions
calling skel_link_create(), chain them in skel__attach(), and close the
corresponding link FDs with skel_closenz() in skel__detach().

Also skip gen_st_ops_shadow() when generating light skeletons so
skel->struct_ops is not emitted between skel->maps and skel->progs,
preserving the ctx layout expected by bpf_gen__finish().

Finally, reject struct_ops maps without BPF_F_LINK in light skeletons.
Because the loader program runs BPF_MAP_UPDATE_ELEM during skel__load(),
non-link struct_ops maps would register prematurely before
skel__attach() and leak in the kernel if a later load step fails.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/bpf/bpftool/gen.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ee680f7c2116..98e92a34326b 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -569,6 +569,8 @@ static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
 static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 {
 	struct bpf_program *prog;
+	struct bpf_map *map;
+	char ident[256];
 
 	bpf_object__for_each_program(prog, obj) {
 		const char *tp_name;
@@ -608,6 +610,30 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 			", bpf_program__name(prog));
 	}
 
+	bpf_object__for_each_map(map, obj) {
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+		if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+			continue;
+		if (!(bpf_map__map_flags(map) & BPF_F_LINK))
+			continue;
+
+		codegen("\
+			\n\
+			\n\
+			static inline int					    \n\
+			%1$s__%2$s__attach(struct %1$s *skel)			    \n\
+			{							    \n\
+				int map_fd = skel->maps.%2$s.map_fd;		    \n\
+				int fd = skel_link_create(map_fd, 0, BPF_STRUCT_OPS);\n\
+										    \n\
+				if (fd > 0)					    \n\
+					skel->links.%2$s_fd = fd;		    \n\
+				return fd;					    \n\
+			}							    \n\
+			", obj_name, ident);
+	}
+
 	codegen("\
 		\n\
 									    \n\
@@ -625,6 +651,20 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 			", obj_name, bpf_program__name(prog));
 	}
 
+	bpf_object__for_each_map(map, obj) {
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+		if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+			continue;
+		if (!(bpf_map__map_flags(map) & BPF_F_LINK))
+			continue;
+
+		codegen("\
+			\n\
+				ret = ret < 0 ? ret : %1$s__%2$s__attach(skel);   \n\
+			", obj_name, ident);
+	}
+
 	codegen("\
 		\n\
 			return ret < 0 ? ret : 0;			    \n\
@@ -642,6 +682,20 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 			", bpf_program__name(prog));
 	}
 
+	bpf_object__for_each_map(map, obj) {
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+		if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+			continue;
+		if (!(bpf_map__map_flags(map) & BPF_F_LINK))
+			continue;
+
+		codegen("\
+			\n\
+				skel_closenz(skel->links.%1$s_fd);	    \n\
+			", ident);
+	}
+
 	codegen("\
 		\n\
 		}							    \n\
@@ -1323,8 +1377,15 @@ static int do_skeleton(int argc, char **argv)
 			continue;
 		}
 
-		if (bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS)
+		if (bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS) {
+			if (use_loader && !(bpf_map__map_flags(map) & BPF_F_LINK)) {
+				p_err("struct_ops map '%s' requires BPF_F_LINK for light skeleton",
+				      bpf_map__name(map));
+				err = -ENOTSUP;
+				goto out;
+			}
 			attach_map_cnt++;
+		}
 
 		map_cnt++;
 	}
@@ -1385,9 +1446,11 @@ static int do_skeleton(int argc, char **argv)
 	}
 
 	btf = bpf_object__btf(obj);
-	err = gen_st_ops_shadow(obj_name, btf, obj);
-	if (err)
-		goto out;
+	if (!use_loader) {
+		err = gen_st_ops_shadow(obj_name, btf, obj);
+		if (err)
+			goto out;
+	}
 
 	if (prog_cnt) {
 		printf("\tstruct {\n");

-- 
2.56.0.455.g6c5a503b38-goog

