Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641446;
	b=rqmyoxGCi6VuK4+UYAol2ycXrWQfHJP27U0prXo98eaMoHWwmCAOEwpeYn3uHuX0ZiIb
	 B5nTp8d2pj1nUBOUhWvNU0vZ/Prwq40D5jx05hkZtwazqZMDCNg4nB8cGy7HrFZvUVZ36
	 PF6uJgD1TM7mwLiH9uoMNbYSF8beSgx1OZvFxng4YUGz416VdsXR6gzeSByMSF3Mc2neA
	 XIbvrvQrC2zfgW13u0YJ6p0DviBUK33P8ZFwS1cQLFlYt2sEZj86KpeGlV7n3P4HBBQlR
	 iJWmIcXzw6dE4qf5ep65xH8eMJRmX3EGeL6dpEnPdgm9UngEuWlQRAcPTQla5vOzCBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=agT2sP37K9WOIXXonUOP0XJUw1BELGxgcJibL+YQ3I0=;
	b=WcP+Llfj2xcfixV2U1tzxxR29UNkrohwkNI++6LTevTHxYdoeBvhcovozXnNgGHJfy+z
	 3XQ9+xdWYXCe0KGoRcn7h5sJh9FVox9ArIIJmask8fca4EVUxaDLOi57MXie3FMTxfpfC
	 USFkvrPf0TmAmCN0KIyFL+VDUVJcsGK20naijxxBe+TM8pAhzGzrLiCjTtftwK3uH0ZA/
	 jQuyi5uGhBPEpKust6Pgj68SPBz1WCwIshBBJqV35VMIx5a7NNbIRHglJbDWlivzVd4ho
	 cf/T9i0BkggjwZwyQfS2oTWf2w9sGsfVhb4KVytW2Krnu7vxShcrO4usgIu2j+NuwOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LbANDaoZ;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B218C606B1CB
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B218C606B1CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LbANDaoZ
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so25021535e9.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793641444; x=1794246244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=agT2sP37K9WOIXXonUOP0XJUw1BELGxgcJibL+YQ3I0=;
        b=LbANDaoZCQKZPwMi7B3S9QQ1jyxcinSKIlOFzSbHLK+XvBF27u/mJb1LiJK+ETn6Op
         FLYumYA0lJOclOTIo4ZStDYTGaQOUR+HHP3QH4UiVhBg7bv/Dy9U3sE8dUFvYYBFjse+
         9LPanSrKnvESryGi1rFCLuC33/0eb9WRbWljeNmO2veWOoE4wauBm3Z7deMmGvrHyLLg
         stzbGPMQUwqDWd+A3hNNbTsyGFVoaZqQv4oLHJPhtQLYfQpzHYy4tj2Kv3bgR7j2k91Z
         bWiURnTQ/CvWe/3cISwM7btd6E0CxsTKsGHCccfFsJFuWNQ7r7Nb5A8iSm65b8j7d5TL
         mbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641444; x=1794246244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=agT2sP37K9WOIXXonUOP0XJUw1BELGxgcJibL+YQ3I0=;
        b=DVSDe5mYk9E44M/BLcpYQLUHdubEhfCxmCvyDeve7W6MXQXc170JYm8X9Yyk4C3d0W
         qobjEdjDuuuqaAL54RVwOSQ3ycrmYX1mFrUE5289g89X9g8fRIYxnmtZk7OIIDsm96h+
         8lsWMKNdCDAxSsbWg3WEw6weJiXSmM3dlqL587IVusA4+znnKYXwzycBmqFpwElxWDdu
         /zaj6kZ3hfaUvaIHuszZf5GQELXFaRBTbXszgs352i6GcJZ1m/YP1I0hWLnkz5BPYtOy
         7U8GoYRuFaTAlGjzgaOwR3DP8pFWzrxkVnBT+gI6u7rH7V6dplvCNmvvWao2UJVdc8+1
         ClCQ==
X-Gm-Message-State: AFq9FYIm5qkObFrufte5fMZdAHQp8h82w56OWEtOHD1UfDLd79XbrtDh
	vLhH/ZV6o0r/MBGdSjDx9jh0lKgRZRBLvFbwy1UZKDkc88xGMMnSsnZPlkFHZ0FuAa8=
X-Gm-Gg: AYBFou1h11KnK+Oi8TUM58u5zor+zLQd7Q3HJFEBQd/J//S6MPbKQOZCyxb54U+zxkM
	dYkIkxwR9zgYmNUzdzMrFeHLbGKcFh1PiDcCvltsS55xUUL4p+gsgoevTT1bOq8KuVy5VpyYKRC
	13OmPMC0mButBO1JBjM4yQTymwk80eGVmRTDBedL82sLK94CBxkQmYuE/L21Wf+rXDJNet/idU7
	C9qyeqX/o8NFvqOJoQwGvwJIYpw+R5JIq5ZZSk4FupkhpZHOgOt7yvNmJTmQlfsJIEL7uo3nrXw
	36mR21UQOBN8zKNSOAfQdDzTysD6VQiWo120Z3KR0wMhv5IDZ3CT9mA8RL3UpnNTfH4tSIoY4zr
	XMXSSfNdUnxwsmZb7bk4WWCPsAhbjACbgHbbew1+gB9BWqNgEymt2SmPJmjuxaIcBPnwrxrIc2R
	NQsQmeHMWkxIpvCFSr3h5ptVnuKPe5QtmYvaZfyEJYBaWiOGT8BeDRprtXW5/7Y2kAjz/iXiaFV
	GZwNjOmDHAsd2ZFFyRyT81GZSmUc5rW0E87QoeZvj4q3r3bIhzLeNXcgHJ0z+vc7bYszvTUKme1
	u3rlMmViIjmP5ZUNyBFJwDkf0BPo930IMM4E/cG4Z/nfSPrA36XD7zhvu23sluM9PKyXPPQMuoP
	i
X-Received: by 2002:a05:600c:a00d:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4ac185bc336mr238059655e9.18.1793641443872;
        Mon, 02 Nov 2026 09:44:03 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4abea533a1esm196311865e9.1.2026.11.02.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:44:03 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
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
	Shuah Khan <shuah@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Tianyi Chen <hi@tychen.cc>,
	Gyutae Bae <gyutae.bae@navercorp.com>,
	Hui Su <sh_def@163.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 1/5] libbpf: Count entry programs for bpf_gen__init()
Date: Mon,  2 Nov 2026 17:43:46 +0000
Message-ID: <20261102174350.472592-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102174350.472592-1-mahe.tardy@gmail.com>
References: <20261102174350.472592-1-mahe.tardy@gmail.com>
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

Commit '259172bb6514 ("libbpf: Fix gen_loader assumption on number of
programs.")' explicitly mention that we may pass a higher number of
progs because we include subprogs and autoload=false to bpf_gen__init()
generating a bigger cleanup section which is harmless.

This is in preparation for the next commits that will introduce cleanup
of the link_fds to bpf_gen__init(). We don't want to overallocate but
have the correct count of progs in this situation so that the
program-slot count matches the programs exposed by the skeleton.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 tools/lib/bpf/libbpf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8fcb8cf39cc0..cd8ff7f42768 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10077,7 +10077,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	 * permit cross-endian creation of "light skeleton".
 	 */
 	if (obj->gen_loader) {
-		int nr_func_ptr_maps = 0, nr_progs = 0, i;
+		int nr_func_ptr_maps = 0, nr_progs = 0, nr_obj_progs = 0, i;
 		bool text_has_callx = false;

 		/*
@@ -10092,12 +10092,16 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			if (prog_is_subprog(obj, &obj->programs[i]) &&
 			    prog_has_callx(&obj->programs[i]))
 				text_has_callx = true;
-		for (i = 0; i < obj->nr_programs; i++)
-			if (obj->programs[i].autoload && !prog_is_subprog(obj, &obj->programs[i]) &&
+		for (i = 0; i < obj->nr_programs; i++) {
+			if (prog_is_subprog(obj, &obj->programs[i]))
+				continue;
+			nr_obj_progs++;
+			if (obj->programs[i].autoload &&
 			    (text_has_callx || prog_has_callx(&obj->programs[i])))
 				nr_progs++;
+		}
 		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level,
-			      obj->nr_programs, obj->nr_maps, nr_func_ptr_maps * nr_progs);
+			      nr_obj_progs, obj->nr_maps, nr_func_ptr_maps * nr_progs);
 	} else if (!is_native_endianness(obj)) {
 		pr_warn("object '%s': loading non-native endianness is unsupported\n", obj->name);
 		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
--
2.43.0

