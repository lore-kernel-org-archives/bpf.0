Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577407;
	b=remw7mzk3hIJoh0QezFeugf/rsDZ5Ip+mYpYq+A12FtH9efsNp5VWQYFJDK1VS3bYBXR
	 +uCaxD6pPTr9Phykf8pykXH6l8DC8lxv23IqHOj6kg30e8klIu7eAuB9TYC8TY0/QEVJw
	 gAlb9V6kUBx/02nMekAaTnSvnUqbEzqJguykeZGyZ91u05vGgoWim3pQ4lU2ekNfOzKUT
	 zYKuiurevZpne7dZ0nkd0EYdavk0PjBpk7B64VUAj20qk0evwpeylhMYYHSdgkCqXtecU
	 yq8Q767BrZbC74UDuorEEHXU+Q+fOQ4WUV0HdU4LBe71vsYsu9l0eS+44VX2r9o5Wbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KqilcjeaFt3c+qDYLpxCO+YLPb7h+LyjAw3oIXtGJJk=;
	b=ej2vkaga8PtLRnKrV6GsrGMe2z68a+We7etp9zs+C62dUSPH/2aLBcaHatXGWMeIw/5b
	 RZt1vuIiab9vtNzmZae7J5vqs3H4ZEI550zXF+MtalvyePVzaUJzWdSgBs3RRv9EXh93l
	 m9VizT0O3lw5/9BYnBOyfNrQo1BJI8ne+fyhWx4THKB1l4wGTinH7B+DpBeFJHXcJbmwO
	 39E1LmlRCUyVRbCyG+YB77BRrO3CQMic4y8tUDVyo0W96ZGpe0pQYEmB4Aj9IJ932I3cO
	 KIV/r+gGudobO1I7KmcarRVOgfa00HOQkA6U6+v7H91k5yeJ2JiRkHmlzrpKjBOylkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NEMiP5c3;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9E606A329
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0D9E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NEMiP5c3
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8c20d68c83fso3410751b3a.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577406; x=1796182206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KqilcjeaFt3c+qDYLpxCO+YLPb7h+LyjAw3oIXtGJJk=;
        b=NEMiP5c3F7h7HX0+yG5HEGhKkWMa8iCNnY6k0HLx0ebLkzUVDbMPFL7FL3D45r1cRd
         mJH+4qBiCcpEUXNhOUmFYtfsGPrDkDJH+XEEkwD0+x1dplDbD0ZPAvIgD6QqrIlJAm6I
         L9B9wH2DvuancxJOXwQlCmNft6GItMHdkq23nBs8R+9c8XvRulv3UJvY37T6i1JY0az6
         9cJ6W3cFR5543aUYYSp7ypeX6Nh1N9XVvUnefK5shW1h4aQoIhPOv6lgTCLCQTUftqiM
         ni73xvu7OXgAx/PC7I6Mwr+LH66R9OyaSN4AuqLliKiHimSlEJ6QvJhffWFKpkfmwbvH
         9gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577406; x=1796182206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KqilcjeaFt3c+qDYLpxCO+YLPb7h+LyjAw3oIXtGJJk=;
        b=KJOlnROgOhv1ZjFRDFWArKeTbLJj/j2jqQoTJjN7QJYdEjoKhUIXEdZ51P9CDS9w8S
         Kb0nNZKPQ0aUSMT1PCEy9UHVAX1D9icxXfq1EWhh3GPzH52lS3nESQsnU/Ko+F2MAMSn
         eoYUnyVaWlI4vr3IpZH/X9QZ/FmOArZF4T7cYLfqK1qP7mgOGbPY4Gmik4cQgOaDcAlc
         ZHqjX2qMgiWH+asV9yF3PbAUZ73JDHNqCQ0sSVul9PLv3HNEKIAo51NOqvlf7y49aEbQ
         I/Rjad4tuBxedDfg/cZfBfZ7JBPT9go4i2XoF7/Ke+Ix2gEQepiMp2OW5EWegXSNdCd2
         QXhQ==
X-Gm-Message-State: APuU4Z9gAj28+sufdeaEV6/g/B54W1pKty+Ua2c9Vj/I5ZDdgvu8m6v7
	/DFg86gt9vO1IqIO4YpKw7tCURO5SwrnsiqMj9z+RPjwnDkWjUv0tql40qzjEW9O
X-Gm-Gg: AZFdTZcFPm+KcUsDOJkxr68iPGPtna+K7ohbLZUulrlA0JOP7LqQdvrLGvXQdWh9OjB
	daJeTiaeKYbTe2YDX7K75sveZu6SDdyQvGYBIpvaqM7pgn7S4dSucA/lQcQx4fxK5L4S2vMaD8p
	xpGOlEt9tyX7muhw/NaDtC106Tzfrhwa1cPhB7lmyUtEV7ZgC7sPOEMs6N87uv3FrkvhWl6bQDE
	iULydAdh8JPpU45DDpgpTaiH04qjZ9WCILO6o9UOjMuF1ZK54OoWR6NvWF4CJIfXHHezw/BNrgE
	zoAjfa1WzmPN2sk5lIC40V5DhLp2J/eT2dHwQ3aUF0ES4Bb178YCBFM3lOc7HeyyFpwFQTUCKtD
	liPM2EnCznmJegOVevVEv7/7duZArkmNxh5jRrtQzG1v28RjqRUBe8b8vJxKRyE5NhQyOUzm55M
	bGNFe84+RPsYmqIqbzPIabpc/qujUtxRjhQeBzZrj1c2WJMmead1+gVA2HiGuNQcVgFtqZ2weEZ
	1fTbpH2yhSVdCkgnfAAuuXvFfUsSfMMuNcp3BgtrBJxPeDdFQhRf5FuB1unGUFdMgy6/cf6YIAk
	vskkyaNPOcIy0AP/mhp8BLnignkFf1wXqHhRKXK+/adMErJPV4vydlzzT6Y+L+Bf0I0NCEjBrJ/
	MJ1SfqT7IAswiRM/DtwLRoyI9dZ7jbCdS+3rownmepnOSeDCyTcDmXNRfaNCJOqmNUMNu+1qEbA
	==
X-Received: by 2002:a05:6300:218b:b0:3e2:2a4b:1bfb with SMTP id adf61e73a8af0-400add57df0mr13759942637.29.1795577406050;
        Tue, 24 Nov 2026 19:30:06 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfebdbasm7843412a12.13.2026.11.24.19.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:30:05 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 04/47] bpf: Do not allow bpf_d_path() by an id of another BTF
Date: Wed, 25 Nov 2026 03:28:55 +0000
Message-ID: <20261125032938.670542-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

For a program that is attached to a program attach_btf_id is an id in
the BTF of the target. bpf_d_path_allowed() looks for it in a list of
kernel functions, it can match by chance. Do not look at the list when
there is a target program.

Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1f35a18ef399..bb79669d1cf4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -980,6 +980,10 @@ BTF_SET_END(btf_allowlist_d_path_fentry)
 
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
 {
+	/* attach_btf_id is a function of the target program */
+	if (prog->aux->dst_prog)
+		return false;
+
 	if (prog->type == BPF_PROG_TYPE_TRACING &&
 	    prog->expected_attach_type == BPF_TRACE_ITER)
 		return true;
-- 
2.55.0

