Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F01CAA7D
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775620012; cv=none; b=XCrApb+aW6Noz7rmw5mKqLllGjxL0Uq9tHcPWYv8md5ijSdaBEJusT2L7pGsVWaBYihwxSYOrDp3WH8PPxhcB0vFLD04jQulRJsSKuv0N44vXP3WZHxcrxL9q7ewInf89opndKU6i7n5YA3uoMAKyADpyr9HTTplmYHmJPq4inc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775620012; c=relaxed/simple;
	bh=AWZaHMp5Y3kDfngrBhyXQ6IWzb5k19vWHsdSsBlE58Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGb0UXGyfrMYn7AKDqNUGXDtExJ52UGYf3t6sA7sEUw4cMRskpTO20VTtechghSbI/ZGGnYxc9jjHZPNlzdFVapiSh3CIwEk+HnBfqs+l4vXIbHhsDxXNxd8l+tBNnnqdDsUVWdaXrOInjmiVupKAt3Yx8vWSJS+mls7/wYcjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6weBStA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6weBStA"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79cd8f8e261so39652307b3.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 20:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775620009; x=1776224809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao/tDqIOqPv5CEUbM/jNG3rVTQ2lzCd5+HVzODHN//0=;
        b=k6weBStAWwGU7e/4EaKujjAn4zkk7pPs6tVouJG8DhaMr8YeiQnt8463+Z3iaf+t9c
         nvTwmjy0Bl1YeTHRt14XR0/wKvNlAk2FbbACGt3/mJOzQ9HPhLEWxdF395HN7BJVEj1V
         KsT6szKkAhipKp66h0jykg7+bxippSC0PxzbouN8GAFXJXRu1EcfmG+jToKKwsmJgJpV
         sHvHGiGBO9PO3qSK/doxvx/3fYAaXpBzgUu/6oiF7bO+B6TiEV648e75bapWMmKiVEuU
         Yx4/fo+SoipGbvcjLnakEoiUUz8tlPIYoq6/bHFSOZSVmhOLhEyghhdVCDakqOixYRDS
         wNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775620009; x=1776224809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao/tDqIOqPv5CEUbM/jNG3rVTQ2lzCd5+HVzODHN//0=;
        b=CBsuxEY9pLHPEEr3Kb+BDeH05ttWVDDV2e5I+1MbBef+n19bl4jJCltSXa0Dpd6NaF
         qWzgExZMGyJkwI+SF05gn7k4hFLkdkrAuvBGQCwgz3Nh+TwVc8ldk3SZeDnagL7ofmGg
         90YXltJKPY+rQ+dWwkeF6wxPg2OTe1zc14lN8syEyz5gOsO+ur+Hp7ovXpgDwRThhHEh
         5qmr7HzG+toTdOVX1lqCO3Rm6zhhkUpi2fVzxtRxewLlUk2Tixk/vzyKI3PTX8mGUd83
         lmdFaZVxnqP7KPuBvaRr5C5FsrHyFgJgHzARi4KHZlJr2alJiK+DyXQnXiSDw9xqfBGd
         njTg==
X-Forwarded-Encrypted: i=1; AJvYcCXFkWaAf4rrMrzXT9JmnoNArNDrF/ooThu2INgdgaxxblJ5gYb10nu8RvkGYch7UkiXqRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPgg/8vDOmwuUreclQqRnSHd7roibE4t6Na8rOqMKvmqEIy5My
	Dempnh3lr+pF578D1kt5/CCuHG4dKyHGaMW6H7/D96SxaH5JwHmJ3bWf
X-Gm-Gg: AeBDietfAihPefkLjMpoqsLvttq4DhbBZlZMGmYmExEZv8g7PeSEQYlKO+4YmKRG0lB
	xR37DEPGU7DBC7c8M8DhGnQctiBGTJJNoBO2rfgD/AC9CFtQtxfMPyHcoYfzjBgot4rPB25BMCm
	V1X7WCmTPUtP3X7VhhDoub1OD4TEmibXhlzFyV0nRjq//8amDUhwgmIzP2LIPGEEh4o4ggalQyX
	QzEjAbkzLlZlQQIvTduqzQLRUkKbNRvpPcMgK/TI5/XgQjYu5+t2X03xwjByhEvQUQDJqB3phG2
	Y2tLfiPVJK4kzBZJsY3QiBCmmKFsx8lvcwQdWGgT0NOW1N6vT4a+QCgU4SIcNS5CU+oVsqXtpTa
	G/W2kouR2IVc4XTrf9V1djq0zhZoFXmRrTiLFnuTYuc43Nnpsft+q2vApyQ0HC7C0Xvr+fAkBXW
	YQx9gplYW8UToEOLaKoztyHA/8kHbbDg7frETCjHo2I5eUfdY4npWFri5D57VMKvZVEU5zzghFi
	MN9MP7tCiF8wxJgj1i935BuaBo5LRy7rucxeiuH+WStVp+oFdNcjHkTtCt3Ot6EmOM=
X-Received: by 2002:a05:690c:e4a9:b0:79f:eed5:ba44 with SMTP id 00721157ae682-7a4d2ff25f4mr153724247b3.2.1775620009216;
        Tue, 07 Apr 2026 20:46:49 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df155csm79129167b3.36.2026.04.07.20.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 20:46:48 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org,
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v4 0/2] bpf: fix short IPv4/IPv6 handling in test_run_skb
Date: Wed,  8 Apr 2026 11:46:21 +0800
Message-ID: <20260408034623.180320-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_prog_test_run_skb() may access IPv4/IPv6 network headers based on
skb->protocol even when the provided test input only contains an
Ethernet header.

Fix it by rejecting such short IPv4/IPv6 inputs before accessing the
L3 headers, and add a selftest that exercises the reported
bpf_skb_adjust_room() path on ETH_HLEN-sized IPv4/IPv6 EtherType
inputs.

Changes in v4:
- Split the selftests into a separate patch.
- Rework the selftest to actually execute a BPF program calling
  bpf_skb_adjust_room().
- Reuse a single struct ethhdr eth_hlen and initialize h_proto from
  the test case table.
- Add the Fixes tag to the test_run.c patch.

Link: https://lore.kernel.org/bpf/CABFUUZF_CWQZrRk=L9cNxO=8Z4iSgGfXi3J=hpzeyTKDbfE2-w@mail.gmail.com/T/#mfabfe7e86bb30c0141fbc9f751b8b1cb07767f01

Sun Jian (2):
  bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb
  selftests/bpf: cover short IPv4/IPv6 inputs with adjust_room

 net/bpf/test_run.c                            | 20 ++++++----
 .../selftests/bpf/prog_tests/empty_skb.c      | 40 +++++++++++++++++--
 tools/testing/selftests/bpf/progs/empty_skb.c |  7 ++++
 3 files changed, 56 insertions(+), 11 deletions(-)


base-commit: cbfffcca2bf0622b601b7eaf477aa29035169184
-- 
2.43.0

