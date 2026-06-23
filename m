Received: from cvsmtppost02.nmdf.navercorp.com (cvsmtppost02.nmdf.navercorp.com [114.111.35.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C734AB01
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183498; cv=none; b=S35A6yOtKcD+6veTO+ks8cEULb2BcB5jHFb9XZag1YIDCnZ11ZijriGx+V1YtZ9EPaZA4J+HBmTdYmpgn3LJZjyHn7+MBk5AorIXNAg8NcpEE8qqSUSEyLBhPm9jrNXl3O4PjeL7BBWvyhmo6jcgnoPnO20n+HoOxQgIrv4e7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183498; c=relaxed/simple;
	bh=PgCIy0qQP20ph1Rm6sKtJRt/8uIUAhmxKHvUba9VM5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=keThGPPCyS+txGoUcEdPyODLouB3oUdFq+rM0qbfmXlRlZmDWqROlc5JSLMKaki2OBZZmmDcg6xwiG3VssWLGVb6S1i1eFvbPU6XR16YEl1wTKs/XWB1PRi8NVinOuW88ormzIOv/C2CGOsjDTk6xjvv4m727eIhAwRbXnm/Q/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com; spf=pass smtp.mailfrom=navercorp.com; dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b=yAlDKPlh; arc=none smtp.client-ip=114.111.35.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b="yAlDKPlh"
Received: from kr0s-real-1 ([10.180.30.112])
  by cvsmtppost02.nmdf.navercorp.com with ESMTP id joIwFYBPQn+emVUuLGmCDw
  for <bpf@vger.kernel.org>;
  Tue, 23 Jun 2026 02:58:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1782183491;
	bh=PgCIy0qQP20ph1Rm6sKtJRt/8uIUAhmxKHvUba9VM5Y=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=yAlDKPlhIlsLrqBBZD7IN+yPVTMRWM93Y7aveuv2yqvilir5zwV1B9Uv3IHRy5jp5
	 Go+uu/EmAmgO1VrbBADh3/jQw2+WYyieK7V0PXU7JUAJph6MR1Fh39wOFJZUvkCqux
	 WJP3dDuTXdso+97Ae81mHtzgtV/M9lYXJOXIiTDe6Yj4gpu5lAVQZQ3zmynffexkk0
	 u8f4VHCFvdrDVehIfKK+TuhclQQi6OlVwntsz2FrMuD3FFDTQYg1xFb77Rfrmw7tCB
	 MmGSOTnwwwGi1JSMYo2ZMSbiDF6KaMClYEtXj5KUgFl51yeGkzfK2khIyhMUIEIKq0
	 3g2b47N3WHerA==
X-Session-ID: D3+Ngjf1RSW6W6+sQiKAKg
X-Works-Send-Opt: TrbwjAumKAumKAbZjAgmKqKXKoJYFBmwFNwYjHmm
X-Works-Smtp-Source: /wn9KxU/FqJZ+Hmmaxgw+6E=
Received: from localhost.localdomain ([10.25.115.253])
  by cvnsmtp01.nmdf.navercorp.com with ESMTP id D3+Ngjf1RSW6W6+sQiKAKg
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Tue, 23 Jun 2026 02:58:10 -0000
From: Gyutae Bae <gyutae.opensource@navercorp.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org
Cc: Gyutae Bae <gyutae.opensource@navercorp.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minsu Jeon <minsu.jeon@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
	Gyutae Bae <gyutae.bae@navercorp.com>
Subject: Re: [RFC bpf-next 0/3] bpf: compare-and-delete (BPF_F_COMPARE) for hash maps
Date: Tue, 23 Jun 2026 11:58:07 +0900
Message-Id: <20260623025807.3119-1-gyutae.opensource@navercorp.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <DJFXOGFS8DXY.4CDI7LHXGHWN@gmail.com>
References: <20260622071649.31541-1-gyutae.opensource@navercorp.com> <DJFXOGFS8DXY.4CDI7LHXGHWN@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon Jun 22, 2026 at 3:32 PM PDT, Alexei Starovoitov wrote:
> Sorry, this is no go.
> There is bpf_spin_lock that use can use to synchronize access
> between bpf progs and user space.
> lookup_and_delete with BPF_F_LOCK uses the same lock.
> Or add another syscall program that is triggered from user space
> that operates on the same map.
> Or convert everything to arena and use whatever algorithm you prefer.

Thanks for taking the time to look at this, and for the pointers.

That makes sense. Using bpf_spin_lock to synchronize the datapath and
user space, and driving the conditional delete from a SYSCALL program
(or moving the state into arena), stays within the existing
programmability model instead of adding new UAPI. At the same time,
it still lets us close the conntrack GC race we were after.

I'll explore those directions rather than a new map primitive.
Appreciate the pointers.
