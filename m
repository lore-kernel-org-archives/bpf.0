Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87BD34A3DF
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851940; cv=none; b=SjpeSunDIu9V/WqfZosRi38CtklTQVlAgx1FuuYDDbKnccsQdBqraUXJzLm4K30++F/jzYWaCbAPoVBpDijbO+2Wep8oZIADXy/noTYeovbN2IQd+oDwPsh0uVVVmLxPjEYjzxwjU+YXiAYc3uQSeNU1/rvN6EDbuM+kscqUZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851940; c=relaxed/simple;
	bh=21JgSM4CfxaQQ5kkKFKodwSaxMTdUC3KtE/P4j+F0Sk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YvRa2Ui7aPRsyFR1ZNYA15Sn+aN8mG5o8O30VuGyZpoL280Ym0f2kDnFMEWWTjv8lWxr9tibbrbb/8lPmqcv72nipLVaKzBxkj0HUkzsVsWGZ9/rQyhxdIuprA6QvXDQlU9BBsX1tiVlMJVYW51q+m4y5ZFzBhleDJlqZNvZb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=GGkHCwDU; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="GGkHCwDU"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c56aa62931so3963716eec.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775851938; x=1776456738; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21JgSM4CfxaQQ5kkKFKodwSaxMTdUC3KtE/P4j+F0Sk=;
        b=GGkHCwDUzqVBR9HRLMBYsxcewiYrVPfHSftGPj19psP0H3QhhrCrVHafJp/jgh8He4
         2H71l+z8+4W8wD0cbhr3TMA6DDoxL0QPJg7RSweGMezwNKH8V+vHXQsCK5D6lAH6rywK
         DjZpmVFeqYd5zZQV3rEpsecx5xHIZtxDJy+cGoEyQlRTrmwbdquu2jub708RN04Fx00c
         XtDaIhbCLv9/JCQP8VDpMyMhbrMAyORmjApSOe5/RyhqCrxy2aUZhaxyc4NLOg6SKSWa
         18GsB1XykjPIHnw4W5fxI/ePrvMHah6pDXUkRZwpZ/LYpoioMxwjoIXK6HfGn1RHT4bT
         WkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775851938; x=1776456738;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21JgSM4CfxaQQ5kkKFKodwSaxMTdUC3KtE/P4j+F0Sk=;
        b=W9CYpf7ecRRw+BgyQP4zlK6CI32XqMhjCshXeb/oJJKKFbHEYM4hxzrTAj1hW8w05S
         zH0RYirRMdees/WHVhRKvppQrwew6b64t3NrlVU8bqRCeg44zByieKzMfTe8Z6R1skwM
         SAhmT2BW1/FMuFTYPEbyPe42jhgWLDupYWHcGKdXjEfBvDz06JLHj3C0AB/S1kNDJ2Dm
         LDJ2V7kQgfwhhi3Cu5LCdmjSbEjFzMW61J+aS56a1xsOiNdXYD2k+MiM7OtHBAyEZBny
         mMkr8VgG+3OT98F184MNrCw+CLAs7sGqcSxSzh51hZqzikkyDpzZxZ8yvOAPjnwiCxzs
         QSug==
X-Forwarded-Encrypted: i=1; AJvYcCUAjFxxb3M6ctQH++DaAld0VIGsP/ufn0iOTiO1vRNsLP5WbjGoAn3fwutfT5tvGJIz9IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQEuTkQHXbJU7xemIrYA7BmWNW5uoyFvTb/xqvsUT7bn6lKaqc
	vsqFs13Dr18Z/CiKsa0h8QGb6qz8jlpz4hIc98lynsWFUsnPFt8jq2I3/UAyXMfUIWE=
X-Gm-Gg: AeBDietXno6fqGZxqYWpzMSGQeNx2uxZwTFHxU48tfS/KflVB97y7sgeayYFzlmmrCE
	jLw+HwlFvqWOLIF2V9l+KpeqtlJoJ3fEZ8kBFNcO9dxMr4Bvhd9mlQy5hQg5HR+Ays1yUvZVVG5
	zoINrc6xnGXKmorpCUD46fgs5hxslsf1qejahissi1cHgR9lWVhzqZWunIHkwdco3qrdL85oSbr
	1zKlLK3OY9C0JBKy3d+lPDmOj/fJlJK1ljpKRbo8h8fC0zyhDBtS6td5E19KuhAJV7wnJU3jlec
	a4c4tPD05UQ4uoswYwYApGgbF73GyiRLKnYFEuli7Xaw3HS1xy7hKq5z7T+JEXIZDDvwJDcg2DB
	28jyFEoP6AA5hFiKJ8UoIZ6csZ6JC7Fv/v+WSIJUtGa3PANK6JrDpjlM79CoRZbePA3Dp/3YTR1
	LnKDfQ
X-Received: by 2002:a05:7300:7495:b0:2ca:e4f2:31ff with SMTP id 5a478bee46e88-2d5873adf3emr3256793eec.6.1775851937645;
        Fri, 10 Apr 2026 13:12:17 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::bf92])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2a4esm7229484eec.16.2026.04.10.13.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 13:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 16:12:15 -0400
Message-Id: <DHPQZ0PMVOS8.OYBETSS0OQ34@etsalapatis.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v5 5/9] selftests/bpf: Add basic libarena
 scaffolding
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu"
 <song@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410163041.8063-1-emil@etsalapatis.com>
 <20260410163041.8063-6-emil@etsalapatis.com>
 <CAPhsuW6f58hx-2AW+X9kwT0oOsRZHW1RA7meWnMjuniJNoMgow@mail.gmail.com>
 <CAP01T76gQXua1e+-zQxHcO2W9XHVe23t+QCCT3bWR_UyRWL27Q@mail.gmail.com>
In-Reply-To: <CAP01T76gQXua1e+-zQxHcO2W9XHVe23t+QCCT3bWR_UyRWL27Q@mail.gmail.com>

On Fri Apr 10, 2026 at 3:44 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Fri, 10 Apr 2026 at 20:39, Song Liu <song@kernel.org> wrote:
>>
>> On Fri, Apr 10, 2026 at 9:31=E2=80=AFAM Emil Tsalapatis <emil@etsalapati=
s.com> wrote:
>> [...]
>> > diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/t=
ools/testing/selftests/bpf/libarena/include/common.h
>> > new file mode 100644
>> > index 000000000000..5acf9b994943
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/bpf/libarena/include/common.h
>> > @@ -0,0 +1,67 @@
>> > +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>> > +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> > +#pragma once
>> > +
>> > +#ifdef __BPF__
>> > +
>> > +#include <vmlinux.h>
>> > +
>> > +#include "bpf_experimental.h"
>>
>> bpf_experimental.h is not needed here.
>>
>> > +#include "bpf_arena_common.h"
>> > +#include "bpf_arena_spin_lock.h"
>>
>> These two headers are indeed needed. However, what's the plan
>> with them? They are not part of libarena at the moment. How should
>> we include them in the future?
>
> I would propose making them part of libarena, and adding libarena's
> header directory to -I for all progs in selftest to simplify
> inclusion.
>

+1 on this. We should have all arena related functionality in a single
directory.

>>
>> Thanks,
>> Song
>>
>> > +#include <asm-generic/errno.h>
>> > +
>> > +#ifndef __BPF_FEATURE_ADDR_SPACE_CAST
>> > +#error "Arena allocators require bpf_addr_space_cast feature"
>> > +#endif
>> > +
>> [...]

