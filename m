Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77734F49F
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824981; cv=none; b=lyLBtJ7HtE9gO9W+AGIEIQ6n+9f6HH0qP2nhvbfezRA1YEHq25BpWNdE/JCOXC1HBk3Bq1KQeZizthVykgVr4N58OOTb8BvhuJRdg9XZ+wAuoINxjcMBFCJqWGSNBjhQeztjX7ckpJa/0VZ8vvx0qnISkuiTKImNtB/ZUosAzv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824981; c=relaxed/simple;
	bh=HwtvY54YILerMds9LF9Yu3gCgXZZKXoBbLTWiokxqus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vuquca842ikERofihLDbxTjRU2I4FmCirBApVOvn5jtKGirsP5fwxN1kFfV4wcJqUDQm8T+qAU0hynB4VnkH9uhWI3V3GuYAzyTBKd23psIpsr0tIvTLg+d+x0/Bw0tXuZiX4cGJNZUbIdg2NfjNWSb8n7gVDX/EdlP3EK86AWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRTCKShI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONO7UMog; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRTCKShI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONO7UMog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787824967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvpeT0h2n6Y7sPgbcxf3s8GKYOw/uhFq32dz5bbuM0g=;
	b=hRTCKShI+RJEFeV6V8MxAq/gNFh6PkP7/ddMFiXznVx9JG9mlEnvRMK1z+ljZhec6iX31A
	mW6NFX1iIgk6iVIpV4/SWcFQa6H2BS3QabN61zRTf2tqMWfixdO4F1o5S/B4BYsjQKIwhl
	TUcKVdOuefzKtqH1gF8YnhicMSSiT5g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-OBrDTdcmPrWwvsEbrGvblg-1; Thu, 27 Aug 2026 06:02:43 -0400
X-MC-Unique: OBrDTdcmPrWwvsEbrGvblg-1
X-Mimecast-MFC-AGG-ID: OBrDTdcmPrWwvsEbrGvblg_1787824963
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495529a93f9so18872465e9.3
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787824962; x=1788429762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xvpeT0h2n6Y7sPgbcxf3s8GKYOw/uhFq32dz5bbuM0g=;
        b=ONO7UMogKexkeATiJ9GScvagl52GtonoBhb/j52T1F7WtCzqlY6oSayp6589LOS2F8
         IiIWpRagsgKhnqjOS7NjI+WkWW+FN/YDhIVFHf/3LMkSsuoIQhpCfqk3LOVNY5Zz7Rur
         bY3bQnTt4Z8K0eJIX/s2DL1R9iZs2hSoO4QDEsyAGOWBNC2w5sv9wV37kz9+z4fxaqFu
         BB8dmp2K88xToa4ybtn74VjIGeMMwHQzEZKPy54SHjbKzHSNGcN1hr4pgTFc4ahUN0NR
         Wxbw7AB1IDpnYlwcGYL1Z4HKpmQtkSFMRGRO+6ldMLHX9tLvZ7hF+rUWUT4HyBMR5OI9
         rK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824962; x=1788429762;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xvpeT0h2n6Y7sPgbcxf3s8GKYOw/uhFq32dz5bbuM0g=;
        b=XP/pn5Nqq+PmH9NXBz6su7uF3pqROz/VJ6OrsNlFDe4Fse1kbxTmrVrtPnrdDWXUHR
         tSiQfAJKDlKRHLI/wIUiJJLjYB3ytWmv6Bh4we8yHCBErcxGEXSBXQHGkbmEc877zqxF
         YvDvlWpZgyYkA1h/4EyUVieoxpIpgMOecHm+K5fnSEILpHzfuC9+eW8E+QeZ8dN9FO54
         sm+C6rJ2tgzt3ne+O/YK3Z0PVNvxgWXpj6A0dpAOMX+rw4VAcp2Y7FSqmp5FSzvJss5m
         3HG/Rx/iJrbOIPLzQ/H1Fzvv2d5+vtLioZ6zP4kHtmzlpOMMN/D35KX+6G4dTmN07TUi
         uFPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4oUfuZlEF2kgYEBd4HahH9X/Mq3HxHfaFOwz6ANu83D5NzMt4jxgQrD7WjT+4DqzC2jM=@vger.kernel.org
X-Gm-Message-State: AFuF++m5+HyWWYV0jQYa0OWkOyALzR3Xd66lB8/WNYes0G7MKv29O6P4
	emkppZX2zPH9vSDYtB855tkZ0q1GnVVYTKz1AOCjybvL9/f3JLjHU7C3bVyaSCOVi3Z9K2QS3cc
	3Ma1I5hLPRpe5W53sIBJDXQlq+QcREwP2IeV/+PPzKLt1V3aum7l8UA==
X-Gm-Gg: AR+sD11DdFJHk3Mg3Tx+ud9PXRRSELulnN2yOIBxUEO8MfW6pbKJCoNdS5xvsXr2xJv
	laPSVpIJu/CRd/3wSBoaVqyQQlhoEqPSSzGLvKg0BiwAme8zzfBn+sks9bUVn9NproyFiOLfYMf
	bh7CvjuzJvrzHHbSjw0kolm6d2jC36uh4XLF3NWW7Ys1OTlw2aK7wNMQX0t1k4mKp50un/4X6zd
	kcJRnyNqLOBatY22fE5foPne7O3us65YMXCQIu3ZE7krKZlpEEacu3uB8acpo2k98x/mI1ZF/z9
	7ObJyqJwaA0jPWogkBhcF6j9c9dXMDKu7rn3uCeHzM3GQoavxO9VqPCDA6KNdiW29e37Pbvp7mN
	yYN/zJu4RjE/2vWEnhWg2+9KF
X-Received: by 2002:a05:600c:4e55:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-499dc723fadmr162882205e9.9.1787824962401;
        Thu, 27 Aug 2026 03:02:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4e55:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-499dc723fadmr162880875e9.9.1787824961898;
        Thu, 27 Aug 2026 03:02:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b49eb3b21sm40420355e9.8.2026.08.27.03.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:02:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 38C38979E22; Thu, 27 Aug 2026 12:02:40 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
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
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/2] bpf: selftests: Check for XDP frags flag in bpf_program__flags()
Date: Thu, 27 Aug 2026 12:02:12 +0200
Message-ID: <20260827100214.169215-2-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827100214.169215-1-toke@redhat.com>
References: <20260827100214.169215-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a check that the BPF_F_XDP_HAS_FRAGS flag shows up in
bpf_program__flags() when opening a BPF program with the 'xdp.flags'
section definition.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
index fce203640f8c..a894b1ab46f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
@@ -18,6 +18,9 @@ static void test_xdp_update_frags(void)
 		return;
 
 	prog = bpf_object__next_program(obj, NULL);
+	ASSERT_EQ(bpf_program__flags(prog) & BPF_F_XDP_HAS_FRAGS,
+		  BPF_F_XDP_HAS_FRAGS, "frags in program flags");
+
 	if (bpf_object__load(obj))
 		return;
 
-- 
2.55.0

