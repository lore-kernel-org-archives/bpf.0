Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=103.117.158.93
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792759618;
	b=wJ+vujBORhCuobqWNF59K2SlNH6y6bRnqDYux2PzMNuMEi4BUvwj5wymTWvLq6lRk4tj
	 4RzUeJKaFyWpGKJHyv3r9cjBfoYUEnfKbO0mI3kBXao+XecqCv9dTYibRYCxm+qzMwobU
	 nwEbp9/juUqVmADQQMJgt0fWMRhj9tKHC6lkVzRoeqSifplvC8nDIrig/8mEifTi4dPwz
	 XNE+VTOlCRjtfylWXX4qVHHmMoB2ql+92oziJlKxpMMgD4xjlxeEm1/LxfxWijMWArkpe
	 n4/Yo6a9QbQqbIathi9rKnDVIhbp/LdYRG1EarpzkZqhW+HlnVykyYLoM3O+z/7Qn/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759618;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=jKGpNzJlpQU9HdMndBuwrQolERcgxUCu0cmVRINNp2w=;
	b=Bd0+jyZhn025ZG51ijQAhaMQmlLzVtNCni9AhLtla54Tx2ojhk+ISzOdVVPhlQizSVKo
	 TKeoxUY+d9edBP6899aflkvQT5wYLnrbbqiMWXgpMepnbY5WBYwwo0Im54wDEk+L60pge
	 Zr1ryAxoUADeKv6s8FSOqxPOpjrsUuXlCYgBulOk0ZebwkTj30OAiG/VamYipknPqmYPv
	 vHbq4CzwJzvFP8mm3G4efE2G9uKXwLr/QmVMMJEmhdsKJ37wBbr6/xBwZ4ibbIaiWQoE4
	 fF3rSuy039rjulhHofkS1X5SGtH/SREKFMbBcIc3nDj3kQtsHnp7WPpY8VZILT5/OTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.in;
	spf=pass smtp.mailfrom=zohomail.in;
	dkim=pass header.d=zohomail.in header.i=adi.sharma@zohomail.in header.a=rsa-sha256 header.s=zoho header.b=yF34Q8X6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=103.117.158.93
Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDAF606A322;
	Fri, 23 Oct 2026 12:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FDAF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.a=rsa-sha256 header.s=zoho header.b=yF34Q8X6
ARC-Seal: i=1; a=rsa-sha256; t=1792759556; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=TSVDsccwJ0O3wjYlVfv2+Y0kHd55rTVY3I74MKTvKNIJxLY33apzqe576ygeRg5pNSVWYacnbJ4sAJIRFULOv3wPAViB5kWXe/FGh0/TJkEwz6BX12cmU87uTmJh8uhhTa/Z3YUv8CL0occngFqxXA1jfwpHBhPvTogxwt+bnrk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1792759556; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jKGpNzJlpQU9HdMndBuwrQolERcgxUCu0cmVRINNp2w=; 
	b=cQNEi+l9n/mTTg9k2QcHtnJAM/dLgEQa91l3VKKujxKzf+kh6FcxpoQxVTJgpi3Gdv/1VeO/S0CFUCwPE1ik7mP7Zk8GGC06kP+R9VINSpfv+QZlUyQGPc5Zp1Jy1mKsd939LDk+7N3FNr6FyUP5ey/e5tPP0VpYJ15P5WGmRpg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792759556;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jKGpNzJlpQU9HdMndBuwrQolERcgxUCu0cmVRINNp2w=;
	b=yF34Q8X6zg8/+DSFfmyI9IlpeeeTqpLXoTNXupyvwiRzWO8JlRa55GWzZKqDnr0M
	uJQ20n7Ilgb0Bi5CiQcaMjBAHExw8riV/EKT62sYPwxC1UIwlHXAKQaTZbron7jMkTH
	vu5gglNg0QjuxRUChfxcefRMbnrfqGpOJIG3T5x4=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1792759554228386.54064309795945; Fri, 23 Oct 2026 18:15:54 +0530 (IST)
Received: from  [14.139.128.24] by mail.zoho.in
	with HTTP;Fri, 23 Oct 2026 18:15:54 +0530 (IST)
Date: Fri, 23 Oct 2026 18:15:54 +0530
From: Aditya Sharma <adi.sharma@zohomail.in>
To: "bpf" <bpf@vger.kernel.org>, "andrii" <andrii@kernel.org>
Cc: "ast" <ast@kernel.org>, "daniel" <daniel@iogearbox.net>,
	"eddyz87" <eddyz87@gmail.com>, "memxor" <memxor@gmail.com>,
	"martin.lau" <martin.lau@linux.dev>, "song" <song@kernel.org>,
	"yonghong.song" <yonghong.song@linux.dev>,
	"jolsa" <jolsa@kernel.org>, "emil" <emil@etsalapatis.com>,
	"ihor.solodrai" <ihor.solodrai@linux.dev>,
	"kpsingh" <kpsingh@kernel.org>, "matt" <matt@bobrowski.net>,
	"rostedt" <rostedt@goodmis.org>, "mhiramat" <mhiramat@kernel.org>,
	"mathieu.desnoyers" <mathieu.desnoyers@efficios.com>,
	"shuah" <shuah@kernel.org>, "puranjay" <puranjay@kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>,
	"linux-kselftest" <linux-kselftest@vger.kernel.org>,
	"Aditya Sharma" <adi.sharma@zohomail.in>
Message-ID: <1a168cbe0aa.30b7e048183449.4003649852775097641@zohomail.in>
In-Reply-To: <20261001072449.1377267-1-adi.sharma@zohomail.in>
References: <20261001072449.1377267-1-adi.sharma@zohomail.in>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix bpf_send_signal_task() from
 kernel thread context
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi,


Gentle ping on this series.

Andrii - patch 1 now removes the nmi_uaccess_okay() check entirely, as
suggested on v1. Is this what you had in mind, or should I change
something?

Thanks,
Aditya
