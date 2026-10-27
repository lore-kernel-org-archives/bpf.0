Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793137022;
	b=5MW3TAn2BrTdF5iazqK1p5zi9YxtNzEKuvXeuANZ3db3JvI+aTTRxH6xqnpZw0v1cvFU
	 kC/SLDACm3+D4kj0u34to34HkxQXcGAB0jVgLuoJ7SCZdx9o05wRKy+PJ1O7srbx4M6VS
	 RvWWvTaaLNcoXrqEyaG0oammsgzfra155E74vfJqD3Wd5q1asTTGcqqYzYWb2KEwgwU1h
	 RqQcBJ8cGP1PSDmZpGywQr34Cd4gH9Gml7vtmBERQZygAsV/ocRraQkQSUvX/UiMVwiTW
	 JC8x/7XnZ3+IH/JrPi6WnvBqJxHajAZwEO1zXHUAn4WbHIw04g9gmNoTTPT0WpkeElg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=QwA00Xd4JXEeFnIr0DG5m9yuPCRBZ016UAYczoXmdAM=;
	b=vIdahrlQ4sZvak5od06gIgJPR5s85XtV04j+UiY3jkG3ra33pxIM++PGgItSZbLzrISG
	 Xc+aQUXomGly/B+qMHs6YHgIXe6T3RdJoT3vVDg/dyuUjT6ca2dWj0UPreDIqlOAT6agp
	 wG3v5U43kg5DzcfVIVpQxilfltvH0XUTRRrr1cbePpsWsG8pyykObXfZt5HYr6qiTKIpT
	 awnFw+cChenPeUMHBkxoPqfrM1lYn485fpaYNUr3fS11BB1EgqXDYejuHHJqn+dz5JY3c
	 bEvq0p8yRqLIQDsyTS0iQHj1l2yVlt+8TeiyJZfMD1xNRZuovU+JBSUpS6DcAKBewcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dSSXjjIW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A4606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 354A4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dSSXjjIW
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso531848a12.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 14:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793137021; cv=none;
        d=google.com; s=arc-20260327;
        b=avokaOwwwEIuJMyl1NAOoF9tUIjkbvaDKWRmvnfNZ+3f+AgdSF5YL4cD4dc1v2lwSX
         74EuYZfqnpZI7cTLMZwFUR8Rmo+C/qRyZuA20wv7Stb02M9wl7aGs5V0O2OkTDEDDJ4B
         R2AIVZMPKmr6OWzygnLhUm6XBkjRTv2UgBUYE87/DQLXyFZVU85Og+Fn11SY+hcuxpx+
         JIARfmuJgmuqtSRr3nuuT6uK7lyDXbDc/O9wwwMCMHZbKkZEWZZplfgbzrLXo0D4qBBA
         Fjb5ZLC9AjVKqBcA5dM4FGLhd9DYyWXttdScumq+QQAAU2lGCa8biTO2lC86CiNtSiEN
         8Ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QwA00Xd4JXEeFnIr0DG5m9yuPCRBZ016UAYczoXmdAM=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=ki1ybxG8HtmbnKJ1i7BB4fo3UuikPireruWRi6ivktILxJBUSMQLNlFF0xPEFBAHVY
         VP1r+3o88J0xycimMWwD/pIcibewMJOy1JEeoYYlDqZh/VqDYdhOlwX/ACpnVMLEKh5H
         2y1bgXCM+zm+lG3HdY7s0/2Jsn/qOE8sj0RU2Vm3TlDHOwp+7YcnpRt2XsQMKmUsoJgp
         +P6bLx/Vptx9befe5WHBMDBAXkyFfYLb1joXoqu2tQhSqsF1hRuB9lWwXGtGkir3ueXt
         7jd4XYYc/VF5j+wj/VqyNBpudAnnoR5AXhob7rUZ0FYS9IcM7srs5FJFK7j5PxCC4aIM
         gupA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793137021; x=1793741821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QwA00Xd4JXEeFnIr0DG5m9yuPCRBZ016UAYczoXmdAM=;
        b=dSSXjjIWKyikwUch6hOd4cGg6YFj9nWLqfYIpLuG9MOLVTQtMx3mZbHoxAjo2MX+Ld
         C+RNGNEnskRLmNQ4qosSBOIEZIATqJDr4HZdbV+as0/1SO4USS7zVA3ZpVZykG5YPa2W
         Uci1R/I8XSmrN6NxEGhSeTNAomVYNqPpJk881RdKYBT+MmJslGKvrHNa0PJ0ctcsamrz
         RqjOgQWhFu1m9qCSQZoFY5Sz3GeQ1i8MdOkYuhiAJSKV9eirEMVQNQflPuVVe5aNwu/7
         ubMTs7HsZDMl1FPE+xIPvW1Tsh5z7OfWO+9G2td10s0fkR+lr63jg442n87nBx2zTgOQ
         foXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793137021; x=1793741821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwA00Xd4JXEeFnIr0DG5m9yuPCRBZ016UAYczoXmdAM=;
        b=GSBb7EawS87d1vFYHlPiYRM42bhbwGHBN9f+G7NaLYQ5QxZRphb06KRf2MdAiEnuD4
         uaipVR6A/aV4aLXyUhqcASHnVtp3cxntgDVX8BFOFQuNXkvcnSvTse7JSzrtRPwbWPmM
         +zFAshjBb3wbmombsltHG+eB4Czs9/oIwTv3TQZeHbZrEa5U24XEy5e5vikGH1vOAJr9
         elUl2CE+xJVEwsv7InY3znS6UV6xKxa+EXdrym8ZP6QZJCKrIgqzd/H1Dff/cSeCatvH
         zF/to3VcDfpRJ4s7jFwdhMgTJFP0Vf5xDE/qE9rOdlleW9Sq95uErONNI2uAmiHC7WFR
         rkCA==
X-Gm-Message-State: AFq9FYInOvdsAEX+m7glqccNWjKNb2TlCKAO6AqX9CFAroXYllOlUFQ0
	I1dhC678mFv35ZuiOLLotQo/m8DJB7fj8ixFyCSYoO5PpPAdDyh3stNzD9Bwafh7At1yZ3xpIvc
	5Vt0/+YxAb+0ph9rUUI9dbMncKEyH/kb6LxqdGJAz
X-Gm-Gg: AYBFou3U7tuccU/gN2hcRUR1QiTuhdK3PZwcrtoWnL5GfyVFGsJVUl1faNguV3pz1CI
	EWLEHMO8ojesprFWWrJ6A80HgHYdqC/A2G2jrbvg8xU3SRRmzfIPzSsZ/HBXKMoG56FbaaFHzUZ
	sfPELiZ7bD7ivpGBUlnpxRSm94CKvydLGDnTDKdX49GcMbDkMOjZdVKBkF4wHvLBwmnzcQyYtP9
	BN2i/AsZpbINkES+D7Nbf/Sk5uHti4FPRF8tsfRMyn8pfzHa/X8qisfOP8pVBjgonHwtp+84D37
	R4XFuQ6K5FQdYSk2kR9hfkMN859DD7Ge6WC0x5wTJH5p1uvS44piWhbxU/K/RZalljq2gC/Z2Yk
	RZLyhVEl1x3Atzc2gxnoQ+sz7CRbWjnZ+lik43un7P+O/UIlnW8S44SWyEE10wpt4b8B5
X-Received: by 2002:a17:907:80d:b0:c45:b99:f282 with SMTP id
 a640c23a62f3a-c49bdda6ee2mr44119666b.7.1793137020271; Tue, 27 Oct 2026
 14:37:00 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-14-wusamuel@google.com>
 <sashiko-outbox-182165@kernel.org>
In-Reply-To: <sashiko-outbox-182165@kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 27 Oct 2026 14:36:48 -0700
X-Gm-Features: AclHuK8GLPAIRQVXEnBkwQRV5iqj4k08I7nT4WWyk-yc_8Brz4DW--Dc5v-8Mlo
Message-ID: <CAG2KctqTH6vZfgm-7ohbxNOmKOcpLUJ+7GPxysfSmUnaBHGiZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/6] selftests/proc: Add KALLSYMS_QUERY tests
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:

[ ... ]

> Should these three skip paths call ksft_exit_skip() with a descriptive
> reason message instead?

Yes, I'll update v3 to use ksft_exit_skip() in the three skip paths.

> Could main() use the kselftest.h reporting helpers (such as
> ksft_print_header(), ksft_set_plan(), ksft_test_result(), and
> ksft_exit_pass() or ksft_finished()) or the kselftest_harness.h macros
> instead of raw assert() and return 0?

I kept assert() to match existing tests in selftests/proc/, but I have
no problem switching to these helpers if maintainers prefer that.
