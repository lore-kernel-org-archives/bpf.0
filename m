Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA979136E2F
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740007; cv=none; b=jDu0rwaQapfdWuoDe00+J+kkOrpjdvEC/Nzd6eQmGBNhgkdut4JaVZwXX7Kk46IppDsHCBK0kmDT9KeUp2qPVY0HCeBBxUA3g0B9w1i9Mm0ovhLCSmbM+iUD1PvNOMQ9pv5VlWB/rp4QUNqchfj/lYlOGuofgnoQ34IOM8rsbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740007; c=relaxed/simple;
	bh=FSP1oV2T/usULlM1VYDd08bWBIJsZLOi020rBF4z6Bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eGtuNHMojoJOybwQ3dk+1Nce8QuEd/NH4BpqQayrXWnpuV96bMTZo93bekxEbcDe7I1kPgndS14YmnEA96O7CvSPB/0HpQWheYo8OwJFX4UPbaq/nd8cF3iDnfSoXC7pIWu9EyCXuVDOMOsKdmCzIHX1Vaj38+fMCChtcXQyfw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdbcJ4bQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdbcJ4bQ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so3910003276.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711740004; x=1712344804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcI6g4FflKBTSfJKFEIW1tJynz7mTB9AleLJZXHTyLA=;
        b=AdbcJ4bQH0gqZlhr0WmKydY/gGFJ5IJBwSncVy5cbhKignhCun7QzKW99CTVCNI+qg
         sTRd3wegMfdO3o1EGbSAcnX/D52gL9lBPcB8On5hwkfuvvXzeTVpTljG5BLvMeSImJHk
         qwfn03aZx2/S5OVRYvblMPx1JuKKgcw9A0ZGbUi0rLQEtg6n4gCTEdxEJPO6QUM97ATO
         +92G7aGo2SS5nWgweMQ5kbak4gEVxDK9KhrYDkZtEzjBAwGPYnc71YDQebYJ4jXVdg2Q
         oG2zXnftogW4eTNIrCxyE8+ozwFpyicYPMX5S9Fn6uNjyzHXDGnWcb/p39ZRcg5oxMFW
         88ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740004; x=1712344804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcI6g4FflKBTSfJKFEIW1tJynz7mTB9AleLJZXHTyLA=;
        b=eHmioJhu7QE2rLbW/AzzqWtn7kgXBNHXAYZQmkzXfwyxRJGLlMwPhvw4J8fr0H3jkW
         fKhkQ6m/OOnxyhKoGaIPGRyxSU9qYs+uNAVj+LhKTU2l4uChgMFIdIFY5P9us3CQnhAO
         TXcE9HG9lfFj3NeLfh2KlwjFs9LNze10xsfLGg96mqJYBHAPNDshFYxoryNVuBayrS0Z
         oAM2qUAmeSl6lsyJFhH+7m+ntCYYzZLy2D9r5uVTLl9wNYLgqN7mWIXHBUSkoXowLRWO
         99NaTxKLM6RJDmaXm72Dkou9b0ebEebDO08g2SLOYItGa3qwitK/wV4f2coRDlTtyFAk
         IV3w==
X-Gm-Message-State: AOJu0YzxxXaOvJmRMG61FdzcY7zyG49m8a+H9aWXBUteGULCluOpiUm5
	R+0HBEoo4J7zSAp47vpGGtulaGVpmi8Z7jGl9lwm6+7ntgW3Ithzcr/Ne86CjqJ6fTS2MJlJCDH
	u+uVVa7qTwpQA4ek38gaNFkgH1C4xKbL2dq8ZE9Kn0tkF8rzjPdwpgmuwdmw6GUDzKT8s8hjlIw
	2jiheiyg/PcWT5vqYZCznTyzU=
X-Google-Smtp-Source: AGHT+IGH0KK9182UUL1GAJNaUHzbTv3CkROT6oxKGok86GWqAdDqq2cDBN1yFx4i1s+2vMk+0slVLQNbbA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:2306:b0:dcc:50ca:e153 with SMTP id
 do6-20020a056902230600b00dcc50cae153mr932390ybb.7.1711740004528; Fri, 29 Mar
 2024 12:20:04 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:51 -0500
In-Reply-To: <20240329191907.1808635-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-7-jrife@google.com>
Subject: [PATCH v1 bpf-next 6/8] selftests/bpf: Add setup/cleanup subcommands
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add optional setup/cleanup subcommands to test_sock_addr.sh to allow
those phases to be driven externally by the sock_addr_kern test program.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/test_sock_addr.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.sh b/tools/testing/selftests/bpf/test_sock_addr.sh
index 3b9fdb8094aa2..dc0dff612b0d2 100755
--- a/tools/testing/selftests/bpf/test_sock_addr.sh
+++ b/tools/testing/selftests/bpf/test_sock_addr.sh
@@ -55,4 +55,12 @@ TEST_IPv4="127.0.0.4/8"
 TEST_IPv6="::6/128"
 MAX_PING_TRIES=5
 
-main
+if [ $# = 0 ]; then
+	main
+elif [ $1 = "setup" ]; then
+	setup
+elif [ $1 = "cleanup" ]; then
+	cleanup
+else
+	echo "invalid option: $1"
+fi
-- 
2.44.0.478.gd926399ef9-goog

