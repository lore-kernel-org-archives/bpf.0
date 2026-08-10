Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A4416860
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375615; cv=pass; b=XZzYscLGnkdvFj+Pl+OwsliD5Fl5ULW7oe8mGxhuzTRaa3VVtfUx0B82w7rxV94GJ8I1FEy4RP0JX//KqXXstWTC8EvzhAuYT+fgZ5zHRzpaXBXS/5CFWu4bnDf9XiY+Ctn2jBL0SaxmdJCFybkVFc+qvqX1oh9sAcc7P1RE/3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375615; c=relaxed/simple;
	bh=+K3xQwVsU4I25WsS9rN34aMOudq9HpZIatSbAmd00XA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=J2HgZRMdfl10QLzR7HLXRmlZvm/QtBdM1o8bfGwpxXSllJ4BMw+1Ay96NigJIDMQHqJYRmmZ6UcAc2xj0KygXHwg/000arIzblSEwIanxNUz/0eE8pTRehtQYIXCCgQcmOUceEXYX+KPD4ng7UHnpetjbK146th+bQ4s1JETmp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+DTLIdm; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+DTLIdm"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c953950dfso14377811fa.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 08:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786375612; cv=none;
        d=google.com; s=arc-20260327;
        b=FAieVSTOLtB+5Rc1dJwWggn/IDLQnvTl6WagWvsuAVX3791i6tvQO/ZmFxmtwkzN58
         8bYk+TVU3UC9DpgccQrFSCmPYbnvfEqVVkbJrD9opXSu0lMUqneQqDH3iJI7mzt+HxIU
         pvmPUviOponD+YabXnosyW3JBgZlpT9A/satp0Ce6mJXcSHeShvRmoQuU5IiPeW9wolL
         mY2PPru1idzh96RxSlYVk8iUCZ0lg9k+F04j3XrDb8coUJtsuY7797pt/XSMAQi6vMDn
         zfC2FqtLl4mSEIoaSw9uKJMe0QEqqnc2YC4A4YWKzL+9x3e5bI5tTcS+HKYP6DOx4sjb
         TkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=v7Xq9mPRy28VF7pzeQHOI5qX2E+YKQ91Mag0+Ocdsy8=;
        fh=ja1Wlih1KilCshJWUJc/9+qi9bYTUBu5WWmC6XxNgY4=;
        b=Z2cZkCwPQk9WAXotXjPnvpIyaS+fPaog5OM2NvLOQaIraEdnY2rIwkRvuVfonPAxcw
         lvCZpqJ3g+/XaWZwHbKSOmTXerrzDKbxG1BGKzo+zsP4t+/qZkA1GgoOrGSSu12oXff1
         rL4n6KVcDWLOCvC/GOBfJSXyhaeCm9K1Nnetx6HzeG/1cd5Xwi7zW9IoEw24Y1mHQ7m4
         PsHwxy1I3inxFj8cMA2xpZtJRVtg9yq6HteNN7OacytM/z88uJ+ivXt7oyhevhphTAqY
         M3MRrwghNRJHDmD90OdePRJdvUS3DAt6uQo2bnbU276SjwcfNgo4haGAX4kEHBma7Gxc
         f6Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786375612; x=1786980412; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7Xq9mPRy28VF7pzeQHOI5qX2E+YKQ91Mag0+Ocdsy8=;
        b=m+DTLIdmyltAbTgSK6Oh8LgH83QVfn7pNusbOrUWZaFd9rBJQP04bQIPejp2IX9k7S
         2BP2vy+LhHMiEQokWF+pnyAbNKFbqdJ4KlkAhyntKmZX9K2UumIEN3oI13ZeyRoy650L
         B8dbeSTpmUpj20yWC/t6Vs6obHcC/VhzG9263wfLri3Q+ZFLtqh0YRqoyLPHU6o7uCGY
         3kUpobk+k9/tesO92oGjUnIr72vvzUvTtMAmW2jXlTjWCY4roL8JVSLjmXuOkSHK4fpE
         suwUnb7S2/QJe5pqDa7yDzXv1szOjQhH+Dc/zyDGFsuuDqB4cx2i2QkfB1iImpy+OxNl
         +2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786375612; x=1786980412;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v7Xq9mPRy28VF7pzeQHOI5qX2E+YKQ91Mag0+Ocdsy8=;
        b=mrNv12e8oLyZnt69sYlW9Bw3eO+ahJoA+6qk/qZVkkiNRhhg7M9S1V3lRpovuOxSp1
         QqSk9CGrnx5g9i6L2ZoFR0WklMv8o9+B0vFl7lCyIN4qY95XYUPHXyduVKjfjohqHxWY
         kvYIdoPT7OmqKYH8qmLHh3t05P0xavlMv/2aN8CtIBZLtmLRsDdKkpqDi+WJr6L2KTZe
         2xoIpA/Bk4jxs4H39NY1hFwRljwXdAU6zaLVxgFxxicjzundSAGWYbaybWlJmoYyUH6g
         pezMtWHKP/B4s0MDhZDWyGK+HV2YffN40a7A/EckEIf6sGd08ka1QbjpyDLjxO1BABlv
         j6/A==
X-Gm-Message-State: AOJu0YzmuM2VxzrXaCTfrVsXIx4WQgTglpo2g8a27BOHoJkA72uZAFf9
	HeU3xLrUl2PExPgvj9McYsy27MiVBOeY8rr2gg2+eIZcfOMW45eaGP0jLV870VgIyc/tVUNY7FE
	SnFV8+lThgukM1B51BRJCi3MvA1KEB5RmB0iRU40=
X-Gm-Gg: AR+sD107XUjlbuFAYH2lV0eQGWUFrXxx8EJFrgXL9YhhWdNxYOHvHQgpZdmfAxp3S5M
	p0t96RVAC/IW8aw/EyjBx7Pm++Grt5vpj70WlpKHBsDECUFJIHOPHj2RJgJYzPX5N1+Pf89gdbY
	jJ+O7q5db6CMNYa/2sXa7G3D6s9HYr5243byzw8vC53rnocl/b5wRRqmWYAOJZZuKaBzTogyZrg
	IJJG7klHEvDmEzBhwdWXtwR/5SDgZWIvno99QFBpddkktiIsbXLBy2GYnwWv19VOD8Mr8f3z6wG
	uSEIvmLHpEqRouU+p8Wnz5xKAREgcPrui+ctZtDBSvsLhVB8NLo3YbgxFrt2Vz+XQVPp4bp8zHi
	fjTkttcVxEZ/xczcvOAUcBH9iCHig4PXDbOu83BTOM/CumVJSue+NHNu5PWU=
X-Received: by 2002:a2e:a99f:0:b0:39a:ea4e:736a with SMTP id
 38308e7fff4ca-39fbb2399e6mr51122981fa.28.1786375612023; Mon, 10 Aug 2026
 08:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Darren Carreras <carrerasdarren@gmail.com>
Date: Mon, 10 Aug 2026 11:26:40 -0400
X-Gm-Features: AUfX_mxx0jT2wYKaLW1ScYYLzHltfU6a9p2yToSyhWc3aGXo6p15FIZz6P6iQFg
Message-ID: <CAOZ_KyvHTkE8Fc6Ah+Z=-U3MoyXGQT0Zxy4L368hO0GRzbX+wg@mail.gmail.com>
Subject: [PATCH bpf-next] libbpf: avoid overflow in BTF.ext bounds check
To: bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 0ee0da46079d4e9453afe2b28acdaadc0f011042 Mon Sep 17 00:00:00 2001
From: Darren Carreras <carrerasdarren@gmail.com>
Date: Mon, 10 Aug 2026 11:20:13 -0400
Subject: [PATCH] libbpf: avoid overflow in BTF.ext bounds check

An invalid BTF.ext subsection length can wrap the pointer addition used by
btf_ext_parse_sec_info() on 32-bit builds. The wrapped pointer passes the
bounds check and parsing then reads beyond the copied BTF.ext data.

Validate the offset and length with subtraction before forming the section
pointer. Add a selftest using an overflowing func_info_len.

Fixes: cf579164e9ea ("libbpf: Support BTF.ext loading and output in
either endianness")
Closes: https://issues.oss-fuzz.com/issues/477315119
Signed-off-by: Darren Carreras <carrerasdarren@gmail.com>
---
 tools/lib/bpf/btf.c.                          | 13 +++++-----
 .../selftests/bpf/prog_tests/test_btf_ext.c.  | 24 +++++++++++++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8417de92d..744f33e2a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3364,7 +3364,7 @@ static
