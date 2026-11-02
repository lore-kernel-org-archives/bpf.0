Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659170;
	b=FdqEy3hxhT256OtEQe3IvYoROMcnjA8EVAi54ZZz469LEJxQ7mXWyiXphrlWj0HM6CAm
	 0+xDGweElWAyq02uZT45gkdfPR8owLafMHgnWYuDiLNbhVO8ea6VCPVRT9NMpboC2uYZg
	 amuZcJsSMS6nxnIHK55SkNYzWxKWqt8camyGqvGQpGpB3p8NLZ+fnPXiZUo9jCBbNK1gP
	 FF3/QMdDEr1FsktSIJDi3+N2C00P+yDojkeoaUdPDguUPcMBXGqWVBdvRiP/Rscs3CWSi
	 13cAoiolQFzFljMOMZm1z6QrfwdE5cxna8sbEusnbNdkquDvHkpGotmz+xWntZfW1MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=g5XH9GbJz9K+fVYPnTUbNJQlpMqHowMb6PcTtvYSgZI=;
	b=erq2vE6OzLHKVTK2/x8O1FabHLGMw1dC+11LhqYdvzF4WOWbkTIjeVx/rKdV/p+ImmJq
	 yIA7VWPdgYeXMi2BbMw86m+8QCYsaPVmbeWGg+S8qG0BO0ugvVWbjqddc+SLpiDaFZSCF
	 GyScu7zLuK8sJfMo6iCKRsDDKEqeM02lDgzAnpiUj64Uys1d7Y0XcMW5FBvYjh/pizG1G
	 3C2CtecVPh1MhHXidrrm4I6+UPu+w6VB5eqh0FQCe6Ls/kapkWDUV2FFkSlBD211fUJxR
	 SIMcW8gCMRd+n3CIZuMpnLHugqIOQRHNYVWcWLefcjSWqorp1CZSudiZKktF0qytYTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TcEd7U/O";
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B7606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 737B7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TcEd7U/O
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e985106c0cso33341395ad.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 14:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659170; x=1794263970; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g5XH9GbJz9K+fVYPnTUbNJQlpMqHowMb6PcTtvYSgZI=;
        b=TcEd7U/OlX9LtOACLuuXqCzdGJudg5Zgsu1EbOUHl9QNKsN9rYg9VC12+7rRNq/Ucz
         ggPJ6ZimxlwljXZP1HsCZNkoeRFGPRjet25kBqeEe6b0bOvanrabymWZJz+twDr8wtv4
         esVOFrnCySx2Ll71Jr77+jsIdowHwmo6U1jbQixI4fASKllbYpN9QKxHkDKrPxEAXnlz
         pMGwrT6Z/OYHvrdf7SQQoY27hamdyv0F/tRTerGGEjheN1kAdmuPQ9F2R+tTLIh89WuY
         9IWk7NmzmTMKhks8aEfQDq3CdY3SMMaUt5PV608w4pLbQsiMRBPg7tpMnaTQbj/NfZEo
         0qHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659170; x=1794263970;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5XH9GbJz9K+fVYPnTUbNJQlpMqHowMb6PcTtvYSgZI=;
        b=EZ2iy9w0aQfQyUEO399eCmSm6Ca6lzCXwRHPd8L8E1MfueGRrwzlkEJbbDt/6WgPQW
         LpJXvq+w8Y5r89uVbFObQdfnBTJp4nj4RpWq3YqG/lef3gsc+LCOSgQ+m5oQbisOeJYQ
         pca5x22BRfMDHopUoABbUaTGCCUJIUBXljJWObFXwV8pQGnI4MxGO74yR1JNB8Id1E+g
         2MEbV494t9CoAMstMwR5A/WIRbU0vqU4TXLMWHX9fIUMplLRnVzVKNXEEiAwWQvtH9WI
         ZuqQOUibmKfzDsHRQRf2CWM7kGtG+UbKEk2iY6HoDxYC9qTVlY8lND3SWqot4M3UTwDr
         nPrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSA6nxN5ADTKDhOX8bPvTZNN4/dW98aYxce3lE3N6yjXD2DsdJrcKtaNQrLjdbMc4zYrc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8k2oFYjVxvkKlY9DCTSiqxd4td2j/SIlqBNpDLOwzJvoBrw/ah
	KO+ugfLpzTx4Cf6zJw4kZbze5N1DgT7eFbmoRos5BHMAp6M/Rfy3eGgC
X-Gm-Gg: AYBFou1FTzmpeEPvK6ju1o+h53cPLwym0iR9UtT63N5umqt5g+6eDlupqyngZ4gG+Gr
	rimoj+qDSoKV2n8okq1GHlYlDKalmkjBoHu9q71Iw+tdzwrX97oNqbzurH9J4hqHLgaCpOJ1wkR
	HDIOIOCjlKilhHCtSs/7IADJs9QTGl8+u2pgciLpZI9GV4Mu5XzlYaHIA5uAdfywd2isqE0PTUD
	Rc+V/aMdphPMiBSIJw3EtZBo/ZtUG76001ODhRfJj5kWFQvxQcJURKlSw4niC1r/gt+qE/otPLZ
	CtnSbcV2h7tCIv4wjcXcK6a7AXbEVL9e6qawRGys0NpASWf6KlTe+i0r9o0MpM7gWaJao1J+Vy2
	jIjR1PBjsV7eLO7iZYb4mYoFWiT5JhMfdH3pZZRA43PqeoAKb1p/05F3+Kt6JbYO22RdK8GMgeH
	CZZcD94hc7ovDePZ7vUnpOFae/9U/3z2+WiZb5BI1n1tI4r0wbhw0IZaWBkX6IjQlV9909INhDi
	7tMraQyzouqpSGnTbBmkb32uCxUahS9kMRNFbmR+2LFwrfYcEvQmtFio3ZV/FetYc8OiqJscbX3
	MOm4XUVsdXXF+EXo9PFODEIWJuPa+XlYMvZ2YIxVwoM2iLXae5ZEJykC41vqNtXikFiHcrxNO0l
	fEODWaCx8X0SdJTNUN9xP6FNE8cOlfgwJ+g==
X-Received: by 2002:a17:902:d485:b0:2dd:c053:a6ee with SMTP id d9443c01a7336-2eb364ce5e3mr104247515ad.32.1793659169696;
        Mon, 02 Nov 2026 14:39:29 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052edasm32812155ad.4.2026.11.02.14.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:39:29 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:39:28 +0000
Message-Id: <DML33YRVJEMW.2HUSMGKYHA4HT@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>, <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <jose.marchesi@oracle.com>, <david.faust@oss.qualcomm.com>
Subject: Re: [PATCH bpf-next v3 8/8] selftests/bpf: skip the struct_ops
 arena tests without compiler support
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261102220717.4079739-9-vineet.gupta@linux.dev>
References: <20261102220717.4079739-1-vineet.gupta@linux.dev> <20261102220717.4079739-9-vineet.gupta@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 02:07 PM Vineet Gupta <vineet.gupta@linux.dev> wrote:
> These are not driven by test_loader, so __skip_without_arena does not
> reach them.  Use the flag-in-.data pattern linked_externs.c already
> uses for the same situation: the program exports skip_tests, and the
> host checks it before attaching and reports SKIP.

cast_kern() is cleaner...
It's a nop when the compiler supports arena.

diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
index 8aa8639..3fffa24 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
@@ -86,7 +86,6 @@ struct bpf_testmod_ops3 testmod_arena = {
 SEC("syscall")
 int trigger(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	u64 __arena *val;
 	int ret;

@@ -94,6 +93,7 @@ int trigger(void *ctx)
 	if (!val)
 		return 1;

+	cast_kern(val);
 	*val = 41;
 	ret = bpf_testmod_ops3_call_test_arena((u64 *)val);
 	if (ret)
@@ -134,6 +134,5 @@ int trigger(void *ctx)
 		return 11;

 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
-#endif
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
index 495faa0..3455ca9 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
@@ -45,13 +45,13 @@ int unrelated(void *ctx)
 SEC("syscall")
 int trigger(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	u64 __arena *val;

 	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
 	if (!val)
 		return 1;

+	cast_kern(val);
 	*val = 41;
 	if (bpf_testmod_ops3_call_test_arena((u64 *)val))
 		return 2;
@@ -59,6 +59,5 @@ int trigger(void *ctx)
 		return 3;

 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
-#endif
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
index a2218cd..afbe59f 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
@@ -80,7 +80,6 @@ struct bpf_testmod_ops3 testmod_arena_member = {
 SEC("syscall")
 int trigger(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	u64 __arena *val;
 	int ret;

@@ -88,6 +87,7 @@ int trigger(void *ctx)
 	if (!val)
 		return 1;

+	cast_kern(val);
 	*val = 41;
 	ret = bpf_testmod_ops3_call_test_arena_member((u64 *)val);
 	if (ret)
@@ -104,6 +104,5 @@ int trigger(void *ctx)
 		return 4;

 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
-#endif
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
index 09b4c74..c4e134e 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
@@ -63,7 +63,6 @@ struct bpf_testmod_ops3 testmod_arena_member_render = {
 SEC("syscall")
 int trigger(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	u64 __arena *val;
 	int ret;

@@ -71,6 +70,7 @@ int trigger(void *ctx)
 	if (!val)
 		return 1;

+	cast_kern(val);
 	*val = 41;
 	ret = bpf_testmod_ops3_call_test_arena_member((u64 *)val);
 	if (ret)
@@ -80,6 +80,5 @@ int trigger(void *ctx)
 		return 3;

 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
-#endif
 	return 0;
 }
