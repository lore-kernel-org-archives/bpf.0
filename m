Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7712D7DDB
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065161; cv=none; b=U0yr+tLGZburiVjzASsukg90wkX9wGXQ5UGhRrpMhPTrRrYfQiVhWjlF6C1tgTiMbkNSzy0dnx5MfsDmqMOZMTIiDyxdjQN8VkSsLTzvC3nqyWwzeRWHjW4054bi84MD1o9YMp+GCtRyl9bvqyIV2YgvMOSUlkOifhx2CSvMzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065161; c=relaxed/simple;
	bh=8KfehZnOG3UMJkozjY/bQF5ANROg0rDRAgmtbiQOYYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GeUE54XQpwtOkarrMNBNW5FMZFKjb0ZLx1KGwxR61+OO85TwceZyrbjZ9X2iITvFugGVi54BXEC5/Uf26Yvk5TEgdl42sba3hMhNQgUbCoVf4iTc3EyI/P5QXneHfWSryL5mD5lLvblqZzB6NlPqgDD8gOaplINPdXuxlf3j4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPpyA1is; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oimPPDOH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPpyA1is";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oimPPDOH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789065152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=etpzICpD0Gll8HM694WIeEO1BPO7Cbi/5lHamRkjCn8=;
	b=UPpyA1is72uVGbi+odZP/Z/qdMobvcGHYjXT73cBn7OQcW72KtWJs4UOemIkKgvM+qYrls
	MYdfhbOHhBkemxDuDNH1ZD6Lc6nxLv8s1RvEgdEsNd1lZeaX09OqY8R6TIdwk9SiWdGk0a
	EzR9Ct8cCIxPH2QweoEpq6MLKwC2sDc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-pUYF_bSuODKSOVLAB1VZpw-1; Thu, 10 Sep 2026 14:32:31 -0400
X-MC-Unique: pUYF_bSuODKSOVLAB1VZpw-1
X-Mimecast-MFC-AGG-ID: pUYF_bSuODKSOVLAB1VZpw_1789065150
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-482e2541c30so59269f8f.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789065150; x=1789669950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etpzICpD0Gll8HM694WIeEO1BPO7Cbi/5lHamRkjCn8=;
        b=oimPPDOHvlpbAxR1N6ZaPWJozltSOupTiOwwEeOFM9dWswi6tywqFi3EItGaBMRBcJ
         SPtnw3+l6a9mK3aj2bwNOY1QR9OTw7dZXDH/Y9MuzfnJSx+07Fvt/S9RQAC22Lw9ku47
         nzzP2vdVe/HPxzRtmHsi8UUdoAKwnji42Evel//dvgPBG61JxXHAVf9i076Y7Y42vLqa
         UaD0C92gT82Ve9QyWo5JBNQbUEAYNRTRZ9GH4sBTkNegFkP8F5o24T7pbBB0e7kmd2jd
         YezqVw7zgnPualUOHcD3ekLxM+uFfnRsXkM4cEqp6MPsaZo0awxjmH0CzEw/2XKAYMQt
         hHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065150; x=1789669950;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=etpzICpD0Gll8HM694WIeEO1BPO7Cbi/5lHamRkjCn8=;
        b=W7NxKJEWOtEWNoKbofyqfNQGjLajF8FEGYMgp1tBCHIRRJN1gwkfn2H6P9z0OCVL8+
         TBdtzb0LafLM/tiE2QSF+7ep6YsR3JzU0IwWyVtAxzYy6RTdp3ZfMU4yaLxf7V9TcXFU
         5Ja37uJGRU3PNMS+BSxDpBQrRZSnFkbHV4AO6WzpT0pdEtumdI70zKqHCF9ZQ4tfUFLc
         Q5vNhJ6yolRGOkvBt1+ivKSB9oJ8YE8ee7UNDt3ZERqAzM4JvUP5dV7gJkhckCMuPfHs
         mFlRlM1n1NY4q86xdA5YkKL3rSMyCg423ZCxFNTqPYje2Auwe0oF9VYy6rvQ7TNRT4vB
         2vUA==
X-Forwarded-Encrypted: i=1; AKwUvBw9es/sXiakV8Hx/9aivlPKcWM+w+pBc4rY6wOjD1oVPqJ9T7bp3Bg6ty1hZn45ZkbvuV4=@vger.kernel.org
X-Gm-Message-State: AFuF++mwvhhybwDYvIIby4u2Llgtr61M9ss0fuV4p7XkREfMONii9q0N
	WaCjCRYgijI6opG/M8TqUO38Ts4Yz6ZYi15NfAcsh2LseyuthUGSBbrNbKzbmpfcbuuUe66EWE4
	GBZBed2vjvyDMHRzaoO5ZaxXju6bIzIfZiAJuWhQMzr8WPbhfvgd7tA==
X-Gm-Gg: AYBFou0DJ0LT4UJohAdTAmBxlZ+q9fcVfGHW/dqSmvaJW8c5eub4yZMcQsmnqINXpQl
	ZynLlKJLVgnHhTfJ6lXIo91q4f7kFXI4boSct0htt40eC1p3jk+wcrvmk+F+uqXAq1p4OJMOTBC
	tUlxhw4r5FvSjc6YtFBpxv/+Sr/ZI+Ws5YwaNKEFLIXh/gnEMOfGkeVs24HTnLtcD5UrOajrOTL
	P335RUJ7YITNAq5+Ke9nfnB9q6uvVYUgvMZiKKehu1SNptGd3YqvbMrpjzdFdaLUgbW8vlniJrg
	QbEtpe4G7Uuh9/IYp50S+RrbA+nrVfzAIZ3Jgyf3/PH7Ted+QSZRxMXkUzs36paJW/Cdz6jJSCy
	yoKB9dU8wsBnj2b8iTNbR26bbAzc=
X-Received: by 2002:a05:6000:290f:b0:486:e6a2:2d8f with SMTP id ffacd0b85a97d-486e9887d65mr818897f8f.19.1789065150031;
        Thu, 10 Sep 2026 11:32:30 -0700 (PDT)
X-Received: by 2002:a05:6000:290f:b0:486:e6a2:2d8f with SMTP id ffacd0b85a97d-486e9887d65mr818865f8f.19.1789065149638;
        Thu, 10 Sep 2026 11:32:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32d5f1sm347938f8f.12.2026.09.10.11.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:32:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E24459B97EA; Thu, 10 Sep 2026 20:32:27 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/4] libbpf: Add bpf_program__add_flags() and bpf_program__clear_flags()
Date: Thu, 10 Sep 2026 20:32:14 +0200
Message-ID: <20260910183222.307208-1-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When changing BPF program flags, applications often need to just add or
remove a single flag, without touching the existing ones. When using the
bpf_program__set_flags() function, this requires reading the existing
flags and doing bitwise manipulations before resetting the result, which
is slightly awkward to do, and easy to forget.

Add two new convenience helpers, bpf_program__add_flags() and
bpf_program__clear_flags(), which wraps bpf_program__set_flags() in the
bitwise operations required to modify flags without clobbering the
existing ones.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c   | 10 ++++++++++
 tools/lib/bpf/libbpf.h   |  6 ++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c036e8a91ed8..221c4fe1fb31 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9938,6 +9938,16 @@ int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
 	return 0;
 }
 
+int bpf_program__add_flags(struct bpf_program *prog, __u32 flags)
+{
+	return bpf_program__set_flags(prog, prog->prog_flags | flags);
+}
+
+int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags)
+{
+	return bpf_program__set_flags(prog, prog->prog_flags & ~flags);
+}
+
 __u32 bpf_program__log_level(const struct bpf_program *prog)
 {
 	return prog->log_level;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..3932bf9cb490 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1011,6 +1011,12 @@ bpf_program__set_expected_attach_type(struct bpf_program *prog,
 LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_flags(struct bpf_program *prog, __u32 flags);
 
+/* Convenience helpers to non-destructively add or clear the specified flags
+ * instead of clobbering them as bpf_program__set_flags() does.
+ */
+LIBBPF_API int bpf_program__add_flags(struct bpf_program *prog, __u32 flags);
+LIBBPF_API int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags);
+
 /* Per-program log level and log buffer getters/setters.
  * See bpf_object_open_opts comments regarding log_level and log_buf
  * interactions.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 08ab2ea881fb..a811a1b3a085 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,7 +458,9 @@ LIBBPF_1.7.0 {
 
 LIBBPF_1.8.0 {
 	global:
+		bpf_program__add_flags;
 		bpf_program__attach_tracing_multi;
+		bpf_program__clear_flags;
 		bpf_program__clone;
 		btf__find_by_name_kind_own;
 		btf__new_empty_opts;
-- 
2.55.0

