Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680222;
	b=Mf52GvgzbpUKepfjCdICzO+Tu8wuvNuVtYK0gBK3pTfRmXZxFFT863J28taEVpX0pP5L
	 I7vM+NEBKvv6VMz7d9VOUiErEa1mSD94dAaBbe8vZ2uwX1FcLldhRBIA1nshUWFFZxdyp
	 1XkRvUs2aseb1FAk3+1EvIWzWWcuRw3YH1iKl/gicttTgWnzn0t2MQ/7ZpZuaiTj5sYD3
	 ky/5wWFZlPZxz6nvPokf6crUCO+/U83h0Ieinaz41iIcEGD59JwJmah0aAcMv4JuJMuGS
	 NTAHX1iKD8JMfUvFKeDc/OlhMUVzKpNiyegQUd34GNqobCksaLGUiXWcMU+2J9j3aVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=KDoBl2NAvYizhN3jBPxIhzmzFKqRpbc+ypo3NQMf9kk=;
	b=SC6ZAfXUhwHFcL7HdFIpru94hIoxCmyIBc5ov/WvyQiouoV5b1sHjwIm4mm78/QhcBZG
	 IgLzNxjzhEugvoPFqzGsfyW+HRWUq7ng9uukZlxwuuPc736TlxSHzF3/xRaDwZnuTUFfN
	 +U6mlH9WW5toKkRKbqaq7cWGAGcsfef6ScsXBM5ddWugCiz3rIiFRkcgxRKHWT24iYryk
	 Ehu/U5pC3QsTXuHbbsamw6Uh90LCo4praGhivnqHu016osIM/l9YR4/BsJsEeoNmSB2Zg
	 WKVdNe5y7NxDJxxfiZ4C8nuJDqjZwv/ZFPaLVGE/+TGXYDLjv69+i5ugGHHcVMRKOUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=usPcCJwa;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17C606A327
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 04:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B17C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=usPcCJwa
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8246b13cbso31767375ad.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 20:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793680221; x=1794285021; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDoBl2NAvYizhN3jBPxIhzmzFKqRpbc+ypo3NQMf9kk=;
        b=usPcCJwa06DZT1k02oSX2KalgvW9MUymY7Xv/igUSbrU94lm8ArzhsmOW6jQLmYfzb
         7sYDr+QUr00ec3PpGQxgw7vYlznc4XudZ9okEiGoD1QKjximiXs8klvcvnEj4+8ZYE8K
         BPYfAJITpmRgOC1LBxBzwPq8JkuYf5xJjkuWPlRBZKViDUp0vNQq2NAglAi7J0iTWszK
         EiUcpGrj0JXSSAgyUnnm4aADI8uU6c9RFSPPN/jYKEl6Ecu78QJ3qS+W279VoipNFJaJ
         wIQd+FCnOJLVr7TW1V1H49rtvRksUYi3Jd6GcUNFgawEjBZWJO3wF0wFJxUkNL4g++SO
         8reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680221; x=1794285021;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KDoBl2NAvYizhN3jBPxIhzmzFKqRpbc+ypo3NQMf9kk=;
        b=V0DYrpL9zKlHpv0mtuIbamCT/Wg2vhJDuA+pnBfKz7ppCCk7tUpxVAGLOQT519jz75
         jVQJoGfw8AlTC0rI8BiBtEwgdZu31kq6FAmUPKLha+GIFXWlRplLym3AhVO8K6KkDJ4B
         /ozfUUA0B8/dmydeGVKj+MMpap4ExNU6bBuzen6DMpzPyoe5QbgtNnsYQMHnMDAxQbff
         tX1gQbXhkd6Ms2iYD0BgkWpZLTx8SL3cO8zq7Rys9ORfl/qEKJzpjsth0w64OoQOE/wY
         wlzz1K+Ct16EBlELgJuQxQYtIowf3T9VYr+M3o4lv4Lu0DSd+1ec7M3WHgyv586S3tmz
         EXLg==
X-Forwarded-Encrypted: i=1; AKwUvBw2lnBv4Qeq64sEIg/Jwm0J/1KPF3iyC+9CwU/JspOjhW8Lr0OhSkNiieHn6L9sLTGKqVE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lJjWx3cVHmNt/7I+mjccn+rrl6I6gjI3eWw96paDCza0I/ibE
	OGky0fARZk6Lg5rQn63RY4yQ954rziVInJK3yjl0zlrXQtGfzX56M62f
X-Gm-Gg: AYBFou12D4KdDQztHKMlnDDIldp9IZXrn6dArUtpVmpsQkx5Sx4Md0VarJt6lgcrFy1
	QAXDBqXu1B8pb8scN+Vj/YIZLTD1SKezUygOxstJ5cSrWC0HaDspuLggczyVakC4wQZaCotl5t2
	oXZrXTff1uVbBcwGWjNjfAO0O3/QjNtosGXyQbhbQMvCaXe9g0IBW90zKyMkZKY+RLWUcHCt5rX
	bplSCSXzp7I7z1c04NG3cfUmmoBdKJ09yY23zgasANq1wGR/dal8JhYKxecdkemq0wj4zaK5zTU
	Ub0Nfyvi1tNj4ehCdVIow8JHS2tC5XIPnz8cKBaxMaON9q3bVMCDLRB7HdZ3S5TqjE3VTEwtQYy
	pWNaAz3Nx0evUy7Yvq1/gauoAaDS0JWc6u/QeGF5a5Miy5Op34z+yNRMZKG7hONMERQQdhOpS+n
	2nGAUXJiQaq52qof1A4ZS3RbnIw+h+7GG059FIeMgKR40TAR3DUj0+pfs7GRIl9sjc0uAIqzNQe
	VbHVSbZk9gU+qvJoTzz2Mi3CUMpRSIVPU9w5ptI09mahQU53C7j5k/2SxXciZxYYr0ePoh7IhFG
	T+Ae4At0UcgcDBiyw4SaH6/s1WSF509jXNKNsxIwVA3K8FeANnbTyiOnnyhXpxNsVtMHSPI6WUq
	pK1phcgw076ScjBaq/5nKnAakUWSuECJaWQ==
X-Received: by 2002:a17:902:db0f:b0:2e8:4066:d247 with SMTP id d9443c01a7336-2eb364cb13emr109056275ad.33.1793680221197;
        Mon, 02 Nov 2026 20:30:21 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3927e856sm33499995ad.50.2026.11.02.20.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 20:30:20 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 04:30:20 +0000
Message-Id: <DMLAKLO9AB4T.X5JCIISSONLF@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add overflow test for
 BTF dump zero-scan
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gu Bin" <gubin@cmss.chinamobile.com>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <alan.maguire@oracle.com>
In-Reply-To: <20261103032619.1378-3-gubin@cmss.chinamobile.com>
References: <20261102131632.1124-1-gubin@cmss.chinamobile.com> <20261103032619.1378-1-gubin@cmss.chinamobile.com> <20261103032619.1378-3-gubin@cmss.chinamobile.com>
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

On Mon, Nov 02, 2026 at 07:26 PM Gu Bin <gubin@cmss.chinamobile.com> wrote:
> +	TEST_BTF_DUMP_DATA_OVER(btf, d, "union", str, union bpf_iter_link_info,
> +				sizeof(union bpf_iter_link_info) - 1, "", {});

sashiko is right. This test fails.

Pls run the test before sending v4.

pw-bot: cr
