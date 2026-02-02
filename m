Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ABA2BCF45
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063813; cv=none; b=J5gS8G3X3FuXQi0CGcfzlOiGH+llueqYmSQV90wt8WPAAMgagXH03sNhQOJgIbQ1MPLJd/KqsmJYlDv1z/d1/7fXcyI8MAwm4zrPDxK93+0oHobJ8FpoZEemm70XyNCakfy0423iP74Sw+RT17vpw+/S9RtVFRJHxfH1zs8+OaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063813; c=relaxed/simple;
	bh=2BTH3es9A4NVSbKDW25hzTc8uhiRRHerJffp5I0oWjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZ/p29DU1xGnTdbw9UmhUXmmXVbMGzf0tWOn/W7sHn2mHBKhD0vTI6FUorQN9mqkn6ytx25tmRgUNak8vi67Z5lT5q2WAK+LgDtkNivl3m5+OKAWVBprRkTvkFSMqGEK5U0H0iHnmX426Ja8CsgUySCNsXDTTD10UEOES3Tknbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOxdMGWA; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOxdMGWA"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b70abe3417so10616878eec.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770063810; x=1770668610; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nfcZKOo/nxpfVT75BXXO0CHfiNvOR9HIy3sNK4ZMz1w=;
        b=UOxdMGWAgpab4iw4Lb+SHKYU/AVhEmZVpX9TfPUc1TDORB0JZexyDGMbCrvfhcj6Ud
         p1iSm/SRssRryvVWp3yeSs80gz/p9e5mbe8tPxN9QHAQvJ1EjskNtqbqkcD/U+h+V269
         zA8s8jJQoMCp6zR7zFWkRjr7tGgohrvf03nBhU5CmXp8Uo+B/hdhcEppAdwUO6dlVl8P
         1TxqSAYTQeepwqRj0g25AHI3VNlDWjWR3PeJYYs4XaYtMBDRtpo1RseZQPIIZEFaqE+L
         LV2n7xXA9Dhh8rC62eXpdXM2MJs5ouhCRR+P+KUl9+dESTNF9h9mQjT3Rsqd3jvW+lB0
         x5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770063810; x=1770668610;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfcZKOo/nxpfVT75BXXO0CHfiNvOR9HIy3sNK4ZMz1w=;
        b=ccV7gZ4UsMzuEmyQGpt6kNvVfcXj3xolyjy/ujZT83syTM5ImG/C1JtYDy710LHm3u
         ngf4xuFd6kAO31vlF8MwfxTvFnpL9iG3VVPC5S83yVaKnLyebXcXkesd+5dsJv7/oFOR
         BdarhI5qIWXEfknVHYvD2N0Vtbc2OwcQneVHMuX2IBomkc4sNcDSANVomC72Q0taHE80
         RCBNtTYyBQJsV876qQMvRAw11xu6MJ4Ulz5ubb0aTbfbWIDNO5IMu6AU3xItTHrtoDT1
         HUVODnbQ80GrJDvsK8LG1tpYwBFyG/VmTuP5Oa9nRtMQkPsElYbNzAVcEZWipafBHcHc
         IJkg==
X-Forwarded-Encrypted: i=1; AJvYcCVbduKdkG4VZlERvj44YsRVURAXmdQM3QAtChLvGp1VaebG2p5dZjI78LUCPDp3APp/Hfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSElzKy4ZAKY1CJviWo6RdYT1nZnDS2IX+4U9rGEeRPnwPaV0T
	NMoDKKJCnwDuPyA841ueAyb1ERz9sZAw/d5R2uPqoMCasG0DLh2ahbEK
X-Gm-Gg: AZuq6aKiOf88kFiP80PVVntfG6q1rDpWCiXvFQSGAQNlZ96IeQsBTChZSNxVlzKd19p
	6cweSXrYgl5zXfZV86178JwUhraIDJRTvo1+aWo7msy4iTnWflCvTKtLFb2XkNeYE9+f75kfJMi
	l4jRfXzeuQm/PPTE52kSvrag/VZxHW60ObrhdCRNMr8ht5jLaZi8bwry/Kl68g98bjRG/VfTMb9
	VAg8tOccSbmzOPXPC5C+AYMe9+cHX5rrT67a3MqwvU0n/PHisX04z9u+FRJN0ej4e4zzMvmwVdN
	tLnE/lF6+zY1DAzbVDRWZs9Gx+d34H6YqP7Usp+zHWx4a3GnoGv8hG4CqQvmZtYKeTNCbUaMx3w
	6G8Mlnbh7DgnazpA1zslqhvGbJc5UavHr2G5vDSSC1LjLjw+ncpcKpzKLwMwzAEhDnp/BYwCW42
	LadE34L9QPjzwXTUJ2b0CF93PnmMtk6ZuvhZ4VpoVM/n+s3fPYuMMZemJk8Ub56KVEow==
X-Received: by 2002:a05:693c:2b10:b0:2a4:61d1:f451 with SMTP id 5a478bee46e88-2b7c86644d6mr5032472eec.16.1770063810337;
        Mon, 02 Feb 2026 12:23:30 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:eca2:6a75:cc8b:c3? ([2620:10d:c090:500::3:5713])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af88dasm22477185eec.32.2026.02.02.12.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:23:30 -0800 (PST)
Message-ID: <b68a122d7a0b046a9ca5527bcf9f50dfea183ce9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for BPF_END
 bitwise tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tianci Cao <ziye@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com
Date: Mon, 02 Feb 2026 12:23:27 -0800
In-Reply-To: <20260202133536.66207-3-ziye@zju.edu.cn>
References: <20260202133536.66207-1-ziye@zju.edu.cn>
	 <20260202133536.66207-3-ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-02 at 21:35 +0800, Tianci Cao wrote:
> Now BPF_END has bitwise tracking support. This patch adds selftests to
> cover various cases of BPF_END (`bswap(16|32|64)`, `be(16|32|64)`,
> `le(16|32|64)`) with bitwise propagation.
>=20
> This patch is based on existing `verifier_bswap.c`, and add several
> types of new tests:
>=20
> 1. Unconditional byte swap operations:
>    - bswap16: port number routing (network byte order conversion)
>    - bswap32: IPv4 subnet routing (network byte order conversion)
>    - bswap64: IPv6 subnet routing (network byte order conversion)
>=20
> 2. Endian conversion operations (architecture-aware):
>    - be16/be32/be64: convert to big-endian
>      * on little-endian: do swap
>      * on big-endian: truncation (16/32-bit) or no-op (64-bit)
>    - le16/le32/le64: convert to little-endian
>      * on big-endian: do swap
>      * on little-endian: truncation (16/32-bit) or no-op (64-bit)
>=20
> Each test simulates realistic networking scenarios where a value is
> masked to a specific range (e.g., 0x3f00), then byte-swapped, and the
> verifier must prove the result stays within expected bounds.
>=20
> Specifically, these selftests are based on dead code elimination:
> If the BPF verifier can precisely track bitwise through byte swap
> operations, it can prune the trap path (invalid memory access) that
> should be unreachable, allowing the program to pass verification.
> If bitwise tracking is incorrect, the verifier cannot prove the trap
> is unreachable, causing verification failure.
>=20
> The tests use preprocessor conditionals (#ifdef __BYTE_ORDER__) to
> verify correct behavior on both little-endian and big-endian
> architectures, and require Clang 18+ for bswap instruction support.
>=20
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> ---

Test cases themselves lgtm.

Essentially you have two groups of tests that follow same template:
- bswap16_port_routing, bswap32_ipv4_subnet_routing, bswap64_ipv6_subnet_ro=
uting
  (why not just bswap16/32/64 as names, by the way?);
- be16_network, be32_network, be64_network, le16_network, le32_network, le6=
4_network.

Maybe define two macros using bswap64_ipv6_subnet_routing and
le64_network as templates to avoid the copy-paste?
E.g. like DEFINE_BAD_OFFSET_TEST in verifier_value_illegal_alu.c.
Also, could you please cut the amount of comments,
test cases are quite self explaining.

[...]
