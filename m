Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4741A508
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182836; cv=none; b=MqzPwe0o3NBq/PBoR4RMRQKl2B5cfx0WO9zR5XpuRM49ej+Y6np2z74Ys4g7QVGbhNTOa8FEaTa1fCVBvZuAXOG0ud38kYl9MI8IZ3i3y9ZLWCaFKbLs/JLoSfE1U3F3lveIJT9eT5pJh7aqCdcR6f8UNyF87vlh14PCMk2F6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182836; c=relaxed/simple;
	bh=LLDgZ0FAh8RhlBoJq35Cs3mJhKUfNkTUqgFTjMLY/tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpYbz3dns2ebEjbTzhGgFlHBDlmzsMeTP5s5qQlPMJ2j15KGgkGEHfldjWCtgRXLA8jnjswB/qsNQutxMoCvSoTTGrUmMwlMF9Le0/q1UAfoZ2Scvx6A7a9Nmyuhvfh4AP7zQPQKF6uD+m9UDR38cso7u8meDwaAoWX/U83OHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R14VFcPp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n7NBIEsj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R14VFcPp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n7NBIEsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788182832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5w3fw8FlazpW0rraJWBP8El+DWfQ3Z4q3hoOZ2MLYk=;
	b=R14VFcPpn0QInW1CnGNQqre/a//96LnRJ6md1jckvHUqWurZC/w7CeWRB3po20NWJ/ujNt
	vBgEbpG+ol1a0Na/fd+7szcGyEDtrV20QvHq3yLT2eFC8LhPm9kdViu+0ttQfNCZAfTZv3
	P7PmQQT9DXBYGT/+K8/DL1N/LHi8z7s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-JtxPjWQ1OXuD2_A9ePcNJQ-1; Mon, 31 Aug 2026 09:27:11 -0400
X-MC-Unique: JtxPjWQ1OXuD2_A9ePcNJQ-1
X-Mimecast-MFC-AGG-ID: JtxPjWQ1OXuD2_A9ePcNJQ_1788182830
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b8c651ac0so34795535e9.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788182830; x=1788787630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E5w3fw8FlazpW0rraJWBP8El+DWfQ3Z4q3hoOZ2MLYk=;
        b=n7NBIEsj7srkxQFgOzBv1MtQH9pH4SpR3hYOphf377HAD2vFNJolR9DsQWrGt6Y73s
         gUDGDG5FW9pmeLKP274/uMo6FDK62j3v7mWNXm79tfT1wVpPcAK7CjbljfTOZiLk05Y0
         fwJJ++ZZoBWU5pliluZg9hcQHIupqh/Ca9jZwNVpVcIFi74c96ViUjczD3+XMSgo++gB
         nasoZ0XBjrb+H7DouzlmQbUI5HJWY820apejsOpXl7+ExzUdtXFnCaZFcJjTW+bc2vUb
         lEYB2BCK5FVV/ZHb+sGGgvEDanM+qijyKCl4oK+g9yr2gUg4/t7CygiA/pKlO/Y9yDcw
         TtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788182830; x=1788787630;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5w3fw8FlazpW0rraJWBP8El+DWfQ3Z4q3hoOZ2MLYk=;
        b=LoZ811o3PSRuDjrU2p+FeLyWZ7xgGEbtGggVdKg/O8SnDD5CgJWAbGG8QiMrBZSkqg
         Ht3t5YuHxTP7e8FPC/z3/OSDnd5rrCvAM+NHiShhc4DqILlORWabskEzDfaMz4lbxANy
         RJL4ACpA+BkgpENM7oXjiJJ9jvQANbzci2LyDzJFTfHF+AzwnuA0bAao7GCNsttTeGtb
         6/D8LwEBJf7KMPw7C4cvzNSQYTcFZI4Gj7yZg03i/AtaF7qX0IwV2ZqVOOKVIt/cqouU
         QdvG3OdmFupWu35JQPJRe5o2sFiu5hCL7iCefTUWC4K6eMOTHcSF1NyiFi32A/wQdUZP
         QW/A==
X-Forwarded-Encrypted: i=1; AHgh+RpbdemSy++LDCxTbSTrOWu47J4zVrGqlDCRSwfNTREq3T70qSQnsbGp5BdVn2yUtaBUH5k=@vger.kernel.org
X-Gm-Message-State: AFuF++nPmXg6roKb4SlOiKl2p6m5WxFO77ODqUC4/4wngbMHmEQv7J3q
	IXkbqfCUuwUW6FYYEKFUxCga+eMGxboSG9JQJC9ygTNf02LXVcrdrlGtCPjTpZjSQTb1E9KFM6v
	4afe4LwXzJyX9Jh9n4g3HYQdf4GT1cfVofiksB0JXMOoX932Hxomdig==
X-Gm-Gg: AR+sD10DFIKw52p+slS3mlhc/D/uzLSNrYnBMuasfpZC81FZRSgPzUUVwEeA+40e6jq
	Guv0NPyb6bU4UAt4K5Efpt50+yId7Y5bX8DtEew5wGILRks/QpD0owfrMTJUzHSuMrNsbASFfJ6
	16KMR/vM2c144kpPGkwwEQdwC0/2DzSpKpgPZqP0RHEa3wZ8kAk9g+4uMT90pulZp6N1mBvZu2M
	i2hEUU1/hDWT4y8WBJPc6u8oUDhTiPRGo2O1QM+CMaWtPdvcuANjYh7OTnFOu3XcWDcGrgrQ7Mw
	VrTysphO68D8R3Y3TLwwtFP30hDkv/s82VP3LyXlGVjldSwEV46sD1ic0aS+2JSkiQq1NFrw0sW
	+RJM5Xx3Pp8HW84OtSusfSh00zbk=
X-Received: by 2002:a05:600c:8b6b:b0:49b:c8e:8e6 with SMTP id 5b1f17b1804b1-49b91bd99b7mr437179945e9.0.1788182829719;
        Mon, 31 Aug 2026 06:27:09 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:49b:c8e:8e6 with SMTP id 5b1f17b1804b1-49b91bd99b7mr437179215e9.0.1788182829334;
        Mon, 31 Aug 2026 06:27:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4c321184sm442371225e9.11.2026.08.31.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:27:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 16AA697C452; Mon, 31 Aug 2026 15:27:08 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Set BPF program flags non-destructively
Date: Mon, 31 Aug 2026 15:26:44 +0200
Message-ID: <20260831132648.65843-4-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831132648.65843-1-toke@redhat.com>
References: <20260831132648.65843-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A couple of the BPF selftests would set the program flags without
looking at the existing program flags, overriding any other flag values.
Change this to always set the flag value non-destructively by OR'ing it
with the existing flags.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/attach_probe.c      | 6 ++++--
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c      | 4 ++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c              | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index e8c1a619e330..7dadb90e7b68 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -543,8 +543,10 @@ static void test_kprobe_sleepable(void)
 		return;
 
 	/* sleepable kprobe test case needs flags set before loading */
-	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable,
-		BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
+	if (!ASSERT_OK(bpf_program__set_flags(
+			       skel->progs.handle_kprobe_sleepable,
+			       bpf_program__flags(skel->progs.handle_kprobe_sleepable) | BPF_F_SLEEPABLE),
+		       "kprobe_sleepable_flags"))
 		goto cleanup;
 
 	if (!ASSERT_OK(test_attach_kprobe_sleepable__load(skel),
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 2e0ddef77ba5..ed3fd0a88dab 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -362,7 +362,7 @@ static void test_attach_api_fails(void)
 	sl_skel->bss->user_ptr = sl_skel;
 
 	err = bpf_program__set_flags(sl_skel->progs.handle_kprobe_multi_sleepable,
-				     BPF_F_SLEEPABLE);
+				     bpf_program__flags(sl_skel->progs.handle_kprobe_multi_sleepable) | BPF_F_SLEEPABLE);
 	if (!ASSERT_OK(err, "sleep_skel_set_flags"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..047dfdc322a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -408,14 +408,14 @@ void test_xdp_metadata(void)
 
 	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
 	bpf_program__set_ifindex(prog, rx_ifindex);
-	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_XDP_DEV_BOUND_ONLY);
 
 	/* Make sure we can load a dev-bound program that performs
 	 * XDP_REDIRECT into a devmap.
 	 */
 	new_prog = bpf_object__find_program_by_name(bpf_obj->obj, "redirect");
 	bpf_program__set_ifindex(new_prog, rx_ifindex);
-	bpf_program__set_flags(new_prog, BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__set_flags(new_prog, bpf_program__flags(new_prog) | BPF_F_XDP_DEV_BOUND_ONLY);
 
 	if (!ASSERT_OK(xdp_metadata__load(bpf_obj), "load skeleton"))
 		goto out;
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6db3b5555a22..c5501b3fdf48 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -845,7 +845,7 @@ int main(int argc, char *argv[])
 
 	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
 	bpf_program__set_ifindex(prog, ifindex);
-	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_XDP_DEV_BOUND_ONLY);
 
 	printf("load bpf program...\n");
 	ret = xdp_hw_metadata__load(bpf_obj);
-- 
2.55.0

