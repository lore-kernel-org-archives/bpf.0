Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC4374726
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602051; cv=pass; b=bv0cNQcWPNfibpVenLCztMeT4tOpNR22pxEjCs9cx8noOGIOJ5wbgx7nYJASjdhBytmK03gfbIEDFn68TWQFF4ykTCj2PFM8gdnAPhwH+/sYP0otB+nRgvD+4nUiT52RYv7osovCHviZckkCKWgQzWtt8xKzU5TXclS8xddPLhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602051; c=relaxed/simple;
	bh=L5xJANLgel+aLMrzXeCRGnfGHztqNSElrKn6E038keM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=agHpTr+5tTYSduYdfVtdx2sA1SnMoigD5y+tdCupeMYyWZGZYGww9nShjofjbdKsNIVlB68sIf9SJ3D4IAwAXvxUOWxjkVhYsDE1AV8SiPvsAK7o6MsluRx2cdipMfnj6HG2o6YGWfzy+t/A1tq7Ituluh/AiYJvPVo6NlVKOig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7aYMVC1; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7aYMVC1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so789381a91.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 12:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780602050; cv=none;
        d=google.com; s=arc-20240605;
        b=DhrqjJoOucG6R+iNVOQjTgzB9q1D4aSmITsXR9loCes8exfW1Osz/6RMI5y/zlDB8W
         c8cDhOLVJ/cW6kcxbieHEJb5m4p+oD0qEpgGj2XW8f6Tn/JdQO+jjWQWaZ+mHOniWhHJ
         BkpH5h4jIEj+kUvMSRhFCmsmbM/rSnFpDLpbJ0elDkdfVtAOeXyS0VoPwdCPT/on+v7R
         JpSDerghRMmUxTqlL5tZlW13vFkd/yILIlO9Gnb2S/T6IKCWmoEjn1DGmHduDZIeamdn
         enhHWER8uYEzusEI8+KZOt4hiFr+mzQo3Ml7vKqe2785viH1NyiZiG7fSFQ8OhNAgT8x
         YKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=G3EmU0iQkXRODP2DFwRhV0QM0MeUZUHSy+Zteg9qolI=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=NCw6tT2z4YZR+bnwUPEoyVwVmZtNfzfaVD5AysmuNQ4Kmuav7BlAULDfwJc7RLm3Fk
         TsZPSdiHBEt2okwk5gEmc/YGuNBUr3VA1GHvu5SpzBpKJyZI7G+D4DxBl2pGZI9lDoAN
         OxB3uHe2LRStzjvcYCe3mI7su/J3yOVZXEEiDXaZ42DznVKbPMmvtASaKHa7QlBMpIR3
         dFBOI7kAcXSLAomDXUOO9QGUC9obA+kMho8QuWE6tpM88vYXZV7J/hDa7kkW3ozzRwI0
         fT+nXKrRsBk+fNJ+bHBbcOwVU+Rrp14sP4KW5ySy3boDLvAk8swlFUaoMQy1DntN+2O2
         M3Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780602050; x=1781206850; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G3EmU0iQkXRODP2DFwRhV0QM0MeUZUHSy+Zteg9qolI=;
        b=b7aYMVC1wv3pPAF/5yC6ogCI2LWZYxQ7BKDBx7LCk5s3AqBKt/M/wiX9BNbVzuH5QO
         JzjafcGVhnLu/8bbuH3+d4YOms3wXULE/UZJX1lZ3xHVMqnov3C3kA9TV/htZwZ900dA
         zQtRtnV0oYK++P2X0wzM0wvy6qCBbtMtIuO98FiR6YqeTxRlA02/D1xcajcR5tO7MggV
         y+GPLNOANG9LZqDbaZL7tPCkRURdKfM/UGLOgx65HTyRWSfHpEb9x1SWyRWKMiAFIvZc
         w6c31jtmoISEW63A7LLpTV3/veUMaAsBfR/ENLOHi2l5sZzd3bGGd63sXRifukoDmS0G
         0P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602050; x=1781206850;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3EmU0iQkXRODP2DFwRhV0QM0MeUZUHSy+Zteg9qolI=;
        b=JRXvQwNugzERCXYCB03DCjQRAyQdV0I9zdkX/M92/UM+HEOOvFksRgtEFymSMQ8AtL
         Wj3zO6ujX0qzXh96XADrXzc5gvKa303OD87B76np3ikCynYxWDoREw1j6dPHl/cKcInK
         pc1oYk366EaXxLZp9+YvF0E4j6nh7PhqKKElpXDkYK4PTQpREz1QkaV8dFbF405IWsc2
         cEGOErCAV5BDmGs+iy80q8XZhU4js8IIJSw1L2y6iTo4L5oMrDyzZNqHeOcpSDtejH0U
         EQnNKc2DXB0aqf2MIsZnJk0CTCC3xJc5dtN8wDxPcb/eIjP2dJ1bzHgodLy0mzmlFWFn
         aGsQ==
X-Gm-Message-State: AOJu0YwZYHrjh8AfzrmfFvLsOn/mr7D6AnwbIob2QSMJdsgpzH43vhzt
	PqZr9Zv/NLyvmp0oWbiJfh/1F1mUo6qO2hUGGyTPV3CnOydGduH6rAeGDJ8/DLN57olvNU5OtmH
	bbuyDBr0l3QPOA2rN02sq8X/p6oIQWZgk5dyK
X-Gm-Gg: Acq92OHjmFhyFCQqqWxJW7Z7eEyStlzn9x+WYzpIZvga+qyru5n0U4mkBW8TJVHK+Um
	NjF8NqyYNDU42PJnS4Afa4GELupDyuXXlOUuE2j+J53+lpodqcMltESkwtkb0kYmXB48CjMnqSO
	rc5uZl2tVxfafw5EqQZh3oLD7U4oWhBF83f5r1DCifE8KmPnfbsDXRup0Bl3aHojd5QH1V933oc
	r0wDU2R4EPuv2rTcQYoz4qTVT4lKez/ZB5X+Z/Uy2/08yajl5Zr0KOS8t9pH0O8mpTqNKoW8kO0
	MMEMfwXZSy4843thcCs=
X-Received: by 2002:a05:6a21:685:b0:3a8:7fb:ca0e with SMTP id
 adf61e73a8af0-3b4ccf91e30mr561499637.23.1780602049696; Thu, 04 Jun 2026
 12:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Josh Marshall <joshua.r.marshall.1991@gmail.com>
Date: Thu, 4 Jun 2026 15:40:37 -0400
X-Gm-Features: AVHnY4IDCOhnqw4_T-r7CKNUgO0Pr8q9BPkn_NB8G6AIuY4QPNqnsrgznHVEDmE
Message-ID: <CAFkJGRcALU7xgVjdikkiYKZp5C4tLMDzM_1kKysQcQk2huoZRg@mail.gmail.com>
Subject: [libbpf] C++ interop failure in "bpf_helpers.h" due to "named
 variadic macros", please advise
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Cross linking https://github.com/libbpf/libbpf/issues/974

I am compiling a userspace C++ program which is intended to handle
eBPF loading and interaction.  This fails with "ISO C++ does not
permit named variadic macros" on "
#include <bpf/bpf_helpers.h>".  This seems counter-intuitive to me,
but it would also be a glaringly obvious bug for over six years so I
must be missing something.  Can someone advise if this is intended
behavior, where remediation should take place, and how?  It isn't
entirely clear to me whether this is PEBKAC or just something no one
has gotten to.
