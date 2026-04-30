Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDD34EF1F
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538729; cv=none; b=SQYJjONhJrjt3ut0iPUZ36GLlLVQFs+ka97G/ojfujzRhTWs9qmkKTIWMF9YaWM8TwNHVJvYWq03MpOGieooitK/pcLZSAh1HuVgYTFyTI2CISONEwBkzo6MV/DkWnNCeDyUlM3LNvPZ1WxlvXT4Uw+ZfNkUPvC6aVp/XYbPv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538729; c=relaxed/simple;
	bh=9JW0V1Jqk2HJn6OAxOnfIEh+5Xo2t8DZwWxlH1Lu1aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U75CNBHiJH39UFujVHNs9gMOHllioCeNPk/rshL3ojPYInBm510IZM+nttwt6kJOcxAivGBT/q3g4RnFy0poxJZxtcsxJJAuyVTnVLqPNUojO6WlWAmqnjRmhzNhzEnNdPdX9xrUwq9zUZLnnwr6kELkQHFcRP99sfXW/dkDiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTHnfBl9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTHnfBl9"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44261378651so1139452f8f.0
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 01:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777538727; x=1778143527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fN/IXRU2Lz0NMw9iP+ZSu90P3q6UL7SFaPXuu14Spgc=;
        b=KTHnfBl92D26BxRulUNdeZfh0wyVfJb1yLbgiOkwvU77WbqsGvXcytIUzdmQHTl5OQ
         02PES6axLP3R9zUe6zkGL0oMC4XyIvN+X4i1HzcLvsJrUpxZ+RsvmdNuKxb3BR1ADKXd
         5pbvhVmuGiDPTxwij/KWkhHMc2Zhnr7+1y/0m6ecIwTfvBvjykJPqFcC7lpG41E84q84
         zQQp6TjDigxNX7tvOtlq0HKj07zsKtLY6HElgmk9Bx4yfuf7BS2dT9JZe6a4/sa/wgZw
         zj2d3HHZbq2sxTXJH0RKsqb/U0CshraHYUDWUZeJki15d0bEJbRKvsiZ3Q3He3PfQFWz
         Om+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777538727; x=1778143527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN/IXRU2Lz0NMw9iP+ZSu90P3q6UL7SFaPXuu14Spgc=;
        b=soL9SOY7xdxml4FpN2b4uCPllBHO4gIOrCfh02kWVVZDiJ9kCngyRUgqNp4ydrSUGc
         f/Xp49wrTZCnZOuhRBxqn7q170hiiEWfy+sHz0W4N4ZecRP7IGL4tkd46q7YObC4Dqgt
         Svpj77U+Qo5mpapoEH6/+FiAOegdCGmHO+V3PBvFzBVZg7YRdOD6ygL/GpXd9rW7rwVb
         lZa1J1A0Ju6hFpBx5bhY+eEEh6ZJe4Qs5h9RsCeIzffEJJ00G4+Vd53uaIh+opZ3twgk
         452ucN1TUdPLVrbt62T2U8ncmT/YGkZRQHsGwDa6k+FiFyco8nzd9vBtXJ9915bSG3+h
         oaOw==
X-Gm-Message-State: AOJu0Yw5s3iU855Crfl0qsUrwUOrjuEqO9ZuY6moqatXmjfH3CBN94uj
	+UzCBd6t58QU1D9JO/W54TuAhUsmS9MmpMuCZqIYPmDb7FLx++KeUx3ZeXuDGg==
X-Gm-Gg: AeBDiesF+iwv/50VKiqgHucO2ECQPAL+IkSntVgtN8LkuVhvl7e3iG3ddZYHb0yJAZw
	MgOArX4N3oTQxPMGpRUxFrJv+Hh5WueXwAOONQqAzW5G3dGoJvMSTO4+9niqWEnbCiADc+V1Gg2
	xteLO2ekA1rhARPvhuItK9vup6SijIvaKKQOgCW52e8UBK5XD7W6utJWgr/S1XI58Cn6Iv3cB8u
	T+TiPAMgNasdftGTbCwxTkYTMtKxW75ZJtNwUG7aD0jvhWZczlRTdMwtb88+J9b3RcfA6OLrk6g
	b8JzNWgoJUQpwhG6pn78Tf9ECq1VwOpNMs8cVjH+XymNWprZ0XqRdijruW54jEPeFV6g9J1OpBU
	ruZ8dyBY7SpsJcUbjRfRVyu2fyduJAX8Np83Q+p7F/XLr8LXcU6c5bla/YO8vrUDvVQAAb1lWUT
	VMJmnmUVDZaPlcKKe0Uy4H0ueK80eVmiQk8w9WtgmtnukRxpH1cq+evYOlzHO98tpsxW1KWNgLD
	fGLzfKrSape5cFndJ38NV7rY7J1eefDmilz+S6XiCsycFhrHEAG7hQ6rmopQssqiG1CoFRPIBPP
	5SMFjGvy/BYvVseEO1SxGYdMhXbMq7JBN/tj6bN5hgTphcZir2WTWw==
X-Received: by 2002:a05:600c:608f:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-48a85e24614mr24896685e9.5.1777538726455;
        Thu, 30 Apr 2026 01:45:26 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00275e75a6e46be847.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:275e:75a6:e46b:e847])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822bceeesm51076305e9.8.2026.04.30.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 01:45:25 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:45:24 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Test insns processed breakdown
Message-ID: <3a5157f4573edaa8846f6fc4041f715136f693b1.1777538384.git.paul.chaignon@gmail.com>
References: <5590f9c67e614ec9054d0c7e74e87cc690a52c56.1777538384.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5590f9c67e614ec9054d0c7e74e87cc690a52c56.1777538384.git.paul.chaignon@gmail.com>

This patch covers in global subprog selftests the new verifier log with
the breakdown of instructions processed by global subprogs. The test
ensures the log line is present and that it has the right number of
subcounts.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v3:
  - Limit testing to one program and use a regex to prevent failures
    across compiler versions.
Changes in v2:
  - Adapted the tests to pass on cpu=v4 and alu32.

 tools/testing/selftests/bpf/progs/verifier_global_subprogs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 1e08aff7532e..dc09d0e2d8ad 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -46,12 +46,13 @@ __noinline long global_dead(void)
 }
 
 SEC("?raw_tp")
-__success __log_level(2)
+__success __log_level(6)
 /* main prog is validated completely first */
 __msg("('global_calls_good_only') is global and assumed valid.")
 /* eventually global_good() is transitively validated as well */
 __msg("Validating global_good() func")
 __msg("('global_good') is safe for any args that match its prototype")
+__msg("insns processed {{[0-9]+\\+[0-9]+\\+[0-9]+$}}")
 int chained_global_func_calls_success(void)
 {
 	int sum = 0;
-- 
2.43.0

