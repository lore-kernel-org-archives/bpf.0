Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237494137A2
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182832; cv=none; b=h3KOBwz1it9IFKKA2UyA4gGwDFLA0NRyE5+DQL4h+69T/xxcb3BDhseo6awcFqS77tTVEsHEbNrZQYlGYy7Qx2jVRzSm4QJrEKhLxhijfAPjSJmZfAjnfCh04UwvvQJ8FZ988x9PA9j2jXtSSptROMEoRNBo3xSTjEMrdNBf6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182832; c=relaxed/simple;
	bh=YgO1TA2tC1JeAml1vHpe8422wxLZ300rZQ8VSHUADNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dfw+DDwhw+PQszcUotUr29HSMUkuSNZYqJyyWnZIGZaCuIFiN/CI8m9axuzI4LVhBRTHEpPX3waBLWbQ3RAE3+R4Ghud6/xjcHX7BxMoaaC6O0eqzWaj+bPlzvdbxtkjJLuAkFICdo+6H/vYCncx08WFECf3WiDZ4sI18+QWmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f162S1Zu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YfuyWL4h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f162S1Zu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfuyWL4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788182830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Py6OFfoOKlM8NbLLcVAPnrT66pPlw+lxtIko4RUMq0c=;
	b=f162S1ZuH6tCh6IdbKrVgOTTQVud8lsmzwCB8EGUm2SEV4w0ahGlUQDa/Ii6KiSxhediWP
	5Fc5/f2zbA5dmr4DfQ61r+Ui3VpkqmK/rw2JrvlmPUBeuaCZrHtohkCn4RqI+0S4o/EXuy
	u9+oG01OzCRxGN7+ZtzWAG//y0BMr40=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-imXQEmyVPSmt6S60d7qX_Q-1; Mon, 31 Aug 2026 09:27:08 -0400
X-MC-Unique: imXQEmyVPSmt6S60d7qX_Q-1
X-Mimecast-MFC-AGG-ID: imXQEmyVPSmt6S60d7qX_Q_1788182827
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so10685365e9.1
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788182827; x=1788787627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Py6OFfoOKlM8NbLLcVAPnrT66pPlw+lxtIko4RUMq0c=;
        b=YfuyWL4hYDTHKb4AjzVwhksRfnw+zYKNBM3AnkEPzVvPemdIMvlmfHMtGqQ9/7nnyk
         RRBHZ14BY1SrQfrS2+iHbZEeCncVqXurwfZLLAugoe3/6tttJKgmwas5ALx4ih591TlP
         1/nbhi+8rvacuuX+oNiHpi/KmAGgUN9ChuagUWJ5ca5Fxv6uO8h/nSys9t1c1pz4nPD3
         C/s8zdFfa7wR3UnzlMCV7neXY/D2IGhN8R4pIGcAa1LdGYwbyJKinWgi97b8e+Kn+MFz
         KlQx/sqpWC8H/xqw8X0Il779CwzwFQCK3IGc7Do9zqiFmCpjC9DkADSiRfV0CLtUUnyH
         OjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788182827; x=1788787627;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Py6OFfoOKlM8NbLLcVAPnrT66pPlw+lxtIko4RUMq0c=;
        b=KeyHTe7aJIJfAEmTKkuRB5rfd5sEOVFQjX9m4Uc67KaurZde61chZq0UF9K8gterij
         UV1w2QOncE8Yp59kXM74Ad92Xui12XTZgXklWA2h8sLvXV7LmcV34KhEKXuT4gv9viG5
         5S+A9MN7AQFkC3djK96Xh78rrvk0y02LYL4dwWZvYz7n5lzLCgJpMLlUOo0I6/tRwU39
         0wOq1uuUV6nLNxmOHJToEMypYVE6LU8U4nCHJzjgkOteHsN7eQqFHThD/5es9nUm6I8I
         E/GIEp9n0FOSDYo/Ks926gESN8zpt87CnkRjw0UX/lhQx6vmuY4Nap4xnunuBcN8pk3m
         dAAg==
X-Forwarded-Encrypted: i=1; AHgh+RovksPoUclES0HPW2irmHLDQm0SGD3E1y5Y70YK9By4yGHRjd7sJMXENTtKDu3IzrHREuc=@vger.kernel.org
X-Gm-Message-State: AFuF++lvXcD+XRA5Og3W6Jz3WP0DwPsSFOmOMASrTDjwoJAj/LXA7qB8
	LaOFP3qUIteWJN36CePNMrAPwdYwAU8gcUTv3uDDXVtyl7UEF2a3BbVJsyawbkbM5CS6az3bFor
	NRnj2Hy0OxnpvTOMj6KeEll6qai9unVa2qoCF8q4aDXBTzN/o9EWq2A==
X-Gm-Gg: AR+sD10C0CyQ83G9DIXljMQp24EiYQZIgbRBgTvSN0HONA6be3+ZRRlPyrpwvfP7cCE
	EVwhXlrtS9J/95twzmYoe8yTpP0A03G4EpmrnweBt8VKWZOel+waob0Frjgg2SAOkj58dcecArH
	njbaAzF9TNW+uq/uHjuRu+MT28xOg9Pbs3l+fWkgoHRuq92Cqx5ZDIHuowuBD6+GGV/G/u0yFZZ
	7gO0oo8ajF7YB2HxUD1WhtK93WXgWR7ik7Es4O74WNWZCBInXQcu6GZ8SKUtsp7y/4Vt6ZRr1Kj
	nI2lA/NGJ9dpElpm7HzsV0ZyjnYdII4kSXujz9bm1oUMBtZQvYToif0Y6v16kIb8/juMyTjGBqL
	zXMFGQmqYFY+a3zyLRDv0NrPn
X-Received: by 2002:a05:600c:8b86:b0:499:8ff5:8ecc with SMTP id 5b1f17b1804b1-49b91c5446emr398325425e9.15.1788182827067;
        Mon, 31 Aug 2026 06:27:07 -0700 (PDT)
X-Received: by 2002:a05:600c:8b86:b0:499:8ff5:8ecc with SMTP id 5b1f17b1804b1-49b91c5446emr398324345e9.15.1788182826619;
        Mon, 31 Aug 2026 06:27:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dd2517sm290839185e9.7.2026.08.31.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:27:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 345C997C44C; Mon, 31 Aug 2026 15:27:05 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
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
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 1/4] libbpf: Move section-defined program flags to prog_flags
Date: Mon, 31 Aug 2026 15:26:41 +0200
Message-ID: <20260831132648.65843-1-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The libbpf section definition modifiers for XDP frags support and
sleepable programs stores the flags bits only in the private section
definition cookie from object open to load time. This has the
unfortunate consequence that API consumers cannot see (or manipulate)
the flag between object open and program load.

In particular, libxdp has special handling of frags-enabled programs to
make them compatible with the dispatcher. This doesn't work on XDP
programs that enable frags through the 'xdp.frags' section definition
because the flag is not visible through bpf_program__flags()[0].

Fix this by changing how libbpf loads the program flags from section
definitions: instead of using the private section definition cookie, add
a setup function to the default section definitions that stores the
flags for sleepable and XDP frags programs in the prog_flags field of
struct bpf_program.

Exposing the flags this way means that any use of
bpf_program__set_flags() will override the flags unless the caller takes
care of updating flags in a non-destructive way. This is unavoidable
with the set-only API, and any user setting flags unconditionally is
already broken in the sense that they will also override any other
current and future flags. A subsequent patch fixes up all in-tree users
of the API.

[0] https://github.com/xdp-project/xdp-tools/issues/587

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v2:
  - Use a generic section setup function that also applies to BPF_F_SLEEPABLE

 tools/lib/bpf/libbpf.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee..27779b4cddd0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7879,6 +7879,19 @@ static int tracing_multi_mod_fd(struct bpf_program *prog, int *btf_obj_fd)
 	return 0;
 }
 
+static int libbpf_setup_prog_flags(struct bpf_program *prog, long cookie)
+{
+	enum sec_def_flags def = cookie;
+
+	if (def & SEC_SLEEPABLE)
+		prog->prog_flags |= BPF_F_SLEEPABLE;
+
+	if (def & SEC_XDP_FRAGS)
+		prog->prog_flags |= BPF_F_XDP_HAS_FRAGS;
+
+	return 0;
+}
+
 /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-supported sec_defs */
 static int libbpf_prepare_prog_load(struct bpf_program *prog,
 				    struct bpf_prog_load_opts *opts, long cookie)
@@ -7889,12 +7902,6 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 	if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
 		opts->expected_attach_type = 0;
 
-	if (def & SEC_SLEEPABLE)
-		opts->prog_flags |= BPF_F_SLEEPABLE;
-
-	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
-		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
-
 	/* special check for usdt to use uprobe_multi link */
 	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK)) {
 		/* for BPF_TRACE_UPROBE_MULTI, user might want to query expected_attach_type
@@ -10099,6 +10106,7 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
 	.expected_attach_type = atype,					    \
 	.cookie = (long)(flags),					    \
+	.prog_setup_fn = libbpf_setup_prog_flags,			    \
 	.prog_prepare_load_fn = libbpf_prepare_prog_load,		    \
 	__VA_ARGS__							    \
 }
-- 
2.55.0

